<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:atom="http://www.w3.org/2005/Atom">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html lang="en">
			<head>
				<meta charset="utf-8"/>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<title><xsl:value-of select="/rss/channel/title"/> · RSS feed</title>
				<style>
					:root{--bg:#0e0e10;--text:#e9e7e3;--muted:#8b8880;--border:#262329;--accent:#ff6a2b;--font-mono:ui-monospace,"SF Mono",SFMono-Regular,Menlo,"JetBrains Mono",Consolas,monospace}
					*{box-sizing:border-box}
					body{font-family:var(--font-mono);background:var(--bg);color:var(--text);margin:0;font-size:16px;line-height:1.7;-webkit-font-smoothing:antialiased}
					main{width:680px;max-width:calc(100% - 2em);margin:auto;padding:2.5em 1em 4em}
					.note{font-size:.8rem;color:var(--muted);border:1px solid var(--border);border-radius:8px;padding:.7em .9em;margin-bottom:2em}
					.note strong{color:var(--accent)}
					h1{color:var(--accent);font-size:1.95rem;margin:0 0 .3em}
					.desc{color:var(--muted);margin:0 0 1.2em}
					a{color:var(--accent);text-decoration:none}
					a:hover{text-decoration:underline}
					.home{font-size:.85rem;color:var(--muted)}
					hr{border:none;border-top:1px solid var(--border);margin:1.6em 0}
					.item{margin-bottom:1.6em}
					.item .title{font-size:1.05rem;color:var(--text)}
					.item .title:hover{color:var(--accent)}
					.item .date{font-size:.78rem;color:var(--accent);margin-top:.2em}
					.item .d{color:var(--muted);font-size:.95rem;margin-top:.2em}
				</style>
			</head>
			<body>
				<main>
					<div class="note">
						<strong>RSS feed.</strong> This is a feed for reader apps (Feedly, Reeder, NetNewsWire). Paste this page's URL into your reader to subscribe.
					</div>
					<h1><xsl:value-of select="/rss/channel/title"/></h1>
					<p class="desc"><xsl:value-of select="/rss/channel/description"/></p>
					<p>
						<a class="home">
							<xsl:attribute name="href"><xsl:value-of select="/rss/channel/link"/></xsl:attribute>
							&#8592; back to site
						</a>
					</p>
					<hr/>
					<xsl:for-each select="/rss/channel/item">
						<div class="item">
							<a class="title">
								<xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
								<xsl:value-of select="title"/>
							</a>
							<div class="date"><xsl:value-of select="substring(pubDate, 1, 16)"/></div>
							<div class="d"><xsl:value-of select="description"/></div>
						</div>
					</xsl:for-each>
				</main>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
