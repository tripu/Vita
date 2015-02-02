function regExpMatch(url, pattern) {    try { return new RegExp(pattern).test(url); } catch(ex) { return false; }    }
    function FindProxyForURL(url, host) {
	if (shExpMatch(url, "*dropbox*")) return 'SOCKS5 localhost:8080';
	if (shExpMatch(url, "*duckduckgo*")) return 'SOCKS5 localhost:8080';
	if (shExpMatch(url, "*elpais.com*")) return 'SOCKS5 localhost:8080';
	if (shExpMatch(url, "*flickr.com*")) return 'SOCKS5 localhost:8080';
	if (shExpMatch(url, "*gist.github.com*")) return 'SOCKS5 localhost:8080';
	if (shExpMatch(url, "*google.com*")) return 'SOCKS5 localhost:8080';
	if (shExpMatch(url, "*googleapis.com*")) return 'SOCKS5 localhost:8080';
	if (shExpMatch(url, "*google.es*")) return 'SOCKS5 localhost:8080';
	if (shExpMatch(url, "*jquery.com*")) return 'DIRECT';
	if (shExpMatch(url, "*twitter.com*")) return 'SOCKS5 localhost:8080';
	if (shExpMatch(url, "*t.co/*")) return 'SOCKS5 localhost:8080';
	if (shExpMatch(url, "*youtube.com*")) return 'SOCKS5 localhost:8080';
	return 'DIRECT';
}