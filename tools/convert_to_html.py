#!/usr/bin/env python3
import sys
import os
import re
import html

def md_to_html(md_text):
    # Process YAML frontmatter
    yaml_match = re.match(r'^---\n(.*?)\n---\n', md_text, re.DOTALL)
    title = "Plataforma de Engenharia Agêntica (labs) — Mobile Whitepaper"
    if yaml_match:
        yaml_text = yaml_match.group(1)
        for line in yaml_text.split('\n'):
            if line.startswith('title:'):
                title = line.replace('title:', '').strip().strip('"').strip("'")
        md_text = md_text[yaml_match.end():]

    # Convert headers
    def replace_header(m):
        level = len(m.group(1))
        text = m.group(2)
        return f'<h{level}>{text}</h{level}>'
    md_text = re.sub(r'^(#{1,6})\s+(.*)$', replace_header, md_text, flags=re.MULTILINE)

    # Convert blockquotes
    md_text = re.sub(r'^>\s*(.*)$', r'<blockquote>\1</blockquote>', md_text, flags=re.MULTILINE)
    # Merge adjacent blockquotes
    md_text = re.sub(r'</blockquote>\s*<blockquote>', '<br/>', md_text)

    # Convert Mermaid code blocks
    def replace_mermaid(m):
        code = m.group(1).strip()
        return f'<div class="mermaid">\n{code}\n</div>'
    md_text = re.sub(r'```mermaid\n(.*?)\n```', replace_mermaid, md_text, flags=re.DOTALL)

    # Convert general code blocks
    def replace_code(m):
        lang = m.group(1)
        code = html.escape(m.group(2).strip())
        return f'<pre><code class="language-{lang}">{code}</code></pre>'
    md_text = re.sub(r'```(\w*)\n(.*?)\n```', replace_code, md_text, flags=re.DOTALL)

    # Convert inline code
    md_text = re.sub(r'`([^`]+)`', r'<code>\1</code>', md_text)

    # Convert bold and italic
    md_text = re.sub(r'\*\*([^*]+)\*\*', r'<strong>\1</strong>', md_text)
    md_text = re.sub(r'\*([^*]+)\*', r'<em>\1</em>', md_text)

    # Convert Markdown links [text](url)
    md_text = re.sub(r'\[([^\]]+)\]\(([^)]+)\)', r'<a href="\2" target="_blank" rel="noopener">\1</a>', md_text)

    # Convert Obsidian wikilinks [[link|label]] or [[link]]
    def replace_wikilink(m):
        content = m.group(1)
        if '|' in content:
            target, label = content.split('|', 1)
        else:
            target, label = content, content
        return f'<span class="wikilink">🔗 {label}</span>'
    md_text = re.sub(r'\[\[([^\]]+)\]\]', replace_wikilink, md_text)

    # Convert lists
    def replace_list(m):
        items = m.group(0).strip().split('\n')
        lis = ''.join([f'<li>{re.sub(r"^\*\s+|^-\s+", "", item)}</li>' for item in items])
        return f'<ul>{lis}</ul>'
    md_text = re.sub(r'^(?:[\*\-]\s+.*(?:\n|$))+', replace_list, md_text, flags=re.MULTILINE)

    # Convert horizontal rules
    md_text = re.sub(r'^---$', '<hr/>', md_text, flags=re.MULTILINE)

    # Wrap remaining paragraphs
    paragraphs = md_text.split('\n\n')
    formatted_p = []
    for p in paragraphs:
        p_str = p.strip()
        if not p_str:
            continue
        if p_str.startswith('<') and not p_str.startswith('<strong') and not p_str.startswith('<a') and not p_str.startswith('<span') and not p_str.startswith('<code'):
            formatted_p.append(p_str)
        else:
            formatted_p.append(f'<p>{p_str}</p>')

    content_html = '\n'.join(formatted_p)

    template = f'''<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0">
    <title>{html.escape(title)}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <style>
        :root {{
            --bg-color: #0f172a;
            --card-bg: #1e293b;
            --card-border: #334155;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --accent-color: #38bdf8;
            --accent-glow: rgba(56, 189, 248, 0.15);
            --code-bg: #090d16;
            --badge-bg: #0369a1;
            --badge-text: #e0f2fe;
            --quote-border: #38bdf8;
        }}

        * {{
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            -webkit-tap-highlight-color: transparent;
        }}

        body {{
            background-color: var(--bg-color);
            color: var(--text-primary);
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            line-height: 1.6;
            font-size: 15px;
            padding: 12px;
            max-width: 680px;
            margin: 0 auto;
            word-wrap: break-word;
        }}

        header {{
            text-align: center;
            padding: 24px 16px;
            background: linear-gradient(185deg, #1e293b 0%, #0f172a 100%);
            border-radius: 16px;
            border: 1px solid var(--card-border);
            margin-bottom: 20px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
        }}

        h1 {{
            font-size: 1.4rem;
            font-weight: 800;
            color: #ffffff;
            line-height: 1.3;
            margin-bottom: 12px;
            background: linear-gradient(90deg, #38bdf8, #818cf8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }}

        h2 {{
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--accent-color);
            margin-top: 24px;
            margin-bottom: 12px;
            padding-bottom: 6px;
            border-bottom: 2px solid var(--card-border);
            display: flex;
            align-items: center;
            gap: 8px;
        }}

        h3 {{
            font-size: 1.05rem;
            font-weight: 600;
            color: #cbd5e1;
            margin-top: 18px;
            margin-bottom: 8px;
        }}

        p {{
            margin-bottom: 12px;
            color: #e2e8f0;
        }}

        a {{
            color: var(--accent-color);
            text-decoration: none;
            word-break: break-all;
            border-bottom: 1px dashed var(--accent-color);
        }}

        a:hover {{
            text-decoration: underline;
        }}

        .wikilink {{
            display: inline-block;
            background: rgba(56, 189, 248, 0.1);
            color: #7dd3fc;
            padding: 2px 8px;
            border-radius: 6px;
            font-size: 0.88em;
            border: 1px solid rgba(56, 189, 248, 0.3);
            margin: 2px 0;
        }}

        blockquote {{
            background: rgba(30, 41, 59, 0.7);
            border-left: 4px solid var(--quote-border);
            padding: 12px 14px;
            border-radius: 0 12px 12px 0;
            margin: 14px 0;
            color: #94a3b8;
            font-size: 0.93rem;
        }}

        ul, ol {{
            margin-left: 20px;
            margin-bottom: 14px;
            color: #cbd5e1;
        }}

        li {{
            margin-bottom: 6px;
        }}

        pre {{
            background: var(--code-bg);
            border: 1px solid var(--card-border);
            border-radius: 12px;
            padding: 14px;
            overflow-x: auto;
            margin: 14px 0;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.82rem;
            line-height: 1.5;
            color: #a5f3fc;
        }}

        code {{
            font-family: 'JetBrains Mono', monospace;
            background: rgba(51, 65, 85, 0.6);
            color: #38bdf8;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 0.85em;
        }}

        pre code {{
            background: transparent;
            padding: 0;
            color: inherit;
        }}

        .mermaid {{
            background: #1e293b;
            border: 1px solid var(--card-border);
            border-radius: 12px;
            padding: 16px 8px;
            margin: 16px 0;
            overflow-x: auto;
            text-align: center;
        }}

        details {{
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 12px;
            padding: 12px;
            margin: 14px 0;
        }}

        summary {{
            font-weight: 600;
            color: var(--accent-color);
            cursor: pointer;
            outline: none;
            padding: 4px 0;
            user-select: none;
        }}

        hr {{
            border: none;
            height: 1px;
            background: var(--card-border);
            margin: 24px 0;
        }}

        table {{
            width: 100%;
            border-collapse: collapse;
            margin: 14px 0;
            font-size: 0.85rem;
        }}

        th, td {{
            padding: 8px 10px;
            border: 1px solid var(--card-border);
            text-align: left;
        }}

        th {{
            background: #334155;
            color: #ffffff;
        }}

        td {{
            background: rgba(30, 41, 59, 0.5);
        }}

        footer {{
            text-align: center;
            padding: 20px;
            font-size: 0.8rem;
            color: var(--text-secondary);
            margin-top: 40px;
            border-top: 1px solid var(--card-border);
        }}

        .mobile-badge {{
            display: inline-block;
            background: #0284c7;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
            text-transform: uppercase;
        }}
    </style>
</head>
<body>
    <header>
        <div class="mobile-badge">📱 Edição Mobile-First</div>
        <h1>{html.escape(title)}</h1>
        <p style="font-size:0.85rem; color:#94a3b8;">Formatado para leitura em Smartphones & Dispositivos Móveis</p>
    </header>

    <main>
        {content_html}
    </main>

    <footer>
        <p>📱 Plataforma de Engenharia Agêntica (labs)</p>
        <p>Documento de Leitura Mobile • Autocontido & Preservado</p>
    </footer>

    <script>
        mermaid.initialize({{
            startOnLoad: true,
            theme: 'dark',
            securityLevel: 'loose',
            flowchart: {{ useMaxWidth: true, htmlLabels: true, curve: 'basis' }}
        }});
    </script>
</body>
</html>'''
    return template

def main():
    input_file = sys.argv[1] if len(sys.argv) > 1 else r'C:\workspace\labs\docs\whitepaper-labs-resumo-executivo-mobile.md'
    output_file = sys.argv[2] if len(sys.argv) > 2 else input_file.replace('.md', '.html')

    if not os.path.exists(input_file):
        print(f"Error: Input file {input_file} does not exist.")
        sys.exit(1)

    with open(input_file, 'r', encoding='utf-8') as f:
        md_content = f.read()

    html_content = md_to_html(md_content)

    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(html_content)

    print(f"Successfully converted {input_file} -> {output_file}")

if __name__ == '__main__':
    main()
