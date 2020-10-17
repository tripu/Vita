const fs = require('fs').promises;
const join = require('path').join;

const series = require('gulp').series;
const Parser = require('commonmark').Parser;

const SOURCES = './tmp2/';
const ENCODING = 'utf8';
const METADATA_CHECK = /\.txt$/i;
const COMMENT_CHECK = /^\s*<!\-\-[^]+\-\->\s*$/;
const COMMENT_TRIM = /(^\s*<!\-\-\s*)|(\s*\-\->\s*$)/g;
const FIELD_FORMAT = /^\s*([^:]+?)\s*:\s*(.+?)\s*$/;

/**
 * Handle a generic error, printing it on stderr and (optionally) rejecting a related promise.
 * @param {object} error - any kind of error that occurred
 * @param {function} reject - (optional) a promise to be rejected because of the error
 */

const handleFailure = (error, reject) => {
    console.error(error);
    if (reject)
        reject(error);
};

/**
 * Parse, from a Commonmark document, the metadata contained in the comment at the beginning, if any.
 * @param {object} node - a “Node” of “type” “document”
 * @returns {Promise} fulfilled with a dictionary of keys/values
 */

const extractMetadata = node => new Promise((resolve, reject) => {
    if (node && 'document' === node.type) {
        const firstChild = node.firstChild;
        if (firstChild && 'html_block' === firstChild.type && COMMENT_CHECK.test(firstChild.literal)) {
            const lines = firstChild.literal.replace(COMMENT_TRIM, '').split('\n');
            const result = {};
            for (const i of lines) {
                const fields = FIELD_FORMAT.exec(i);
                if(fields)
                    result[fields[1]] = fields[2];
            }
            resolve(result);
        } else
            resolve();
    } else
        reject('extractMetadata(): param “node” is not a valid Node of type “document”');
});

const processFile = node => new Promise((resolve, reject) => {
    const w = node.walker();
    let event, item;
    while(event = w.next()) {
        item = event.node;
        if (event.entering){
            console.log(item.type, item.literal);
        }
    }
});

/**
 * Parse a regular Commonmark file
 * @param {string} path - the full path to the file
 * @param {string} filename - the filename alone
 * @returns {Promise} fulfilled with ...
 */

const parseFile = (path, filename) => new Promise((resolve, reject) => {
    fs.readFile(path, ENCODING)
        .then(c => {
            if (METADATA_CHECK.test(path))
                resolve({});
            const reader = new Parser();
            return reader.parse(c);
        })
        .then(t => {
            extractMetadata(t)
                .then(m => {
                    const result = {};
                    result['__file'] = filename;
                    result['__metadata'] = m;
                    result['__node'] = t.toString();
                    resolve(result);
                });
            })
        .catch(e => handleFailure(e, reject));
});

const traverseDir = (dir, prefix) => new Promise((resolve, reject) => {
    const result = {};
    const subtree = [];
    if (prefix)
        result['__dir'] = prefix;
    fs.readdir(dir, {withFileTypes: true})
        .then(entries => {
            for (const e of entries) {
                const childDir = join(dir, e.name);
                if (e.isDirectory())
                    subtree.push(traverseDir(childDir, e.name));
                else
                    subtree.push(parseFile(childDir, e.name));
            }
            Promise.all(subtree)
                .then(items => {
                    for (const i of items) {
                        if (i['__dir']) {
                            result[i['__dir']] = i;
                            delete i['__dir'];
                        } else if (i['__file']) {
                            result[i['__file']] = i;
                            delete i['__file'];
                        } else if (i['__metadata'])
                            result['__metadata'] = i['__metadata'];
                    }
                    resolve(result);
                });
        })
        .catch(e => handleFailure(e, reject));
});

const cleanOutput = () => new Promise((resolve, reject) => {
    resolve();
});

const readSources = () => new Promise((resolve, reject) => {
    traverseDir(SOURCES)
        .then(tree => {
            console.log(tree);
            resolve(tree);
        })
        .catch(e => handleFailure(e, reject));
});

const build = series(cleanOutput, readSources);

exports.clean = cleanOutput;
exports.build = build;
exports.default = build;
