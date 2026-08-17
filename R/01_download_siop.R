# Baixa uma fotografia oficial do SIOP pelo pacote orcamentoBR.
# A consulta documentada retorna PLOA e LOA. Fases intermediárias da CMO
# devem ser fornecidas como snapshots separados em data/raw.
if (!requireNamespace("orcamentoBR", quietly=TRUE)) install.packages("orcamentoBR", repos="https://cloud.r-project.org")
if (!requireNamespace("jsonlite", quietly=TRUE)) install.packages("jsonlite", repos="https://cloud.r-project.org")

ano <- as.integer(Sys.getenv("EXERCICIO", format(Sys.Date(), "%Y")))
dir.create("data/raw", recursive=TRUE, showWarnings=FALSE)

x <- orcamentoBR::despesaDetalhada(
  exercicio=ano, Esfera=TRUE, Orgao=TRUE, UO=TRUE, Funcao=TRUE,
  Subfuncao=TRUE, Programa=TRUE, Acao=TRUE, PlanoOrcamentario=TRUE,
  Subtitulo=TRUE, GND=TRUE, ModalidadeAplicacao=TRUE, Fonte=TRUE,
  IdUso=TRUE, ResultadoPrimario=TRUE, valorPLOA=TRUE, valorLOA=TRUE,
  valorLOAmaisCredito=FALSE, valorEmpenhado=FALSE, valorLiquidado=FALSE,
  valorPago=FALSE, incluiDescricoes=TRUE, detalheMaximo=FALSE, timeout=0
)
saveRDS(x, sprintf("data/raw/siop_%s.rds", ano))
write.csv(x, sprintf("data/raw/siop_%s.csv", ano), row.names=FALSE, fileEncoding="UTF-8")
message("Snapshot salvo. Confira os nomes das colunas antes de executar a comparação.")
