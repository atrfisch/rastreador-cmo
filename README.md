# Rastreador CMO

Painel estático para acompanhar modificações entre fases do orçamento federal, com processamento em R e publicação no GitHub Pages.

## Rodar localmente

```bash
npm install
npm run dev
```

## Publicar
1. Crie um repositório e envie estes arquivos para a branch `main`.
2. Em **Settings > Pages > Build and deployment**, selecione **GitHub Actions**.
3. Execute o workflow **Publicar painel**.

## Dados reais
O painel vem com dados demonstrativos. Para baixar um snapshot oficial:

```bash
Rscript R/01_download_siop.R
```

A função documentada do pacote oferece PLOA e LOA. Relatórios setoriais e relatório final precisam ser obtidos e normalizados como snapshots próprios caso não estejam expostos como valores diretamente pelo endpoint consultado. Depois, execute:

```bash
Rscript R/02_comparar_fases.R data/raw/base.csv data/raw/comparada.csv public/data/movimentacoes.json
Rscript R/03_metadata.R
```

Consulte `METODOLOGIA.md` antes de ligar origens a destinos no Sankey.
