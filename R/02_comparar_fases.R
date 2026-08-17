# Comparador genérico de dois snapshots normalizados.
# Uso: Rscript R/02_comparar_fases.R base.csv comparada.csv public/data/movimentacoes.json
args <- commandArgs(trailingOnly=TRUE)
if(length(args)<3) stop("Informe: base.csv comparada.csv saida.json")
if(!requireNamespace("jsonlite",quietly=TRUE)) install.packages("jsonlite",repos="https://cloud.r-project.org")
a <- read.csv(args[1],check.names=FALSE,encoding="UTF-8"); b <- read.csv(args[2],check.names=FALSE,encoding="UTF-8")
# Os snapshots devem conter: chave, area, instrumento e valor.
required <- c("chave","area","instrumento","valor")
if(!all(required %in% names(a)) || !all(required %in% names(b))) stop("Normalize os arquivos com as colunas: chave, area, instrumento, valor")
names(a)[names(a)=="valor"] <- "valor_base"; names(b)[names(b)=="valor"] <- "valor_comparado"
z <- merge(a,b,by="chave",all=TRUE,suffixes=c("_base","_comparada")); z$valor_base[is.na(z$valor_base)]<-0; z$valor_comparado[is.na(z$valor_comparado)]<-0; z$delta<-z$valor_comparado-z$valor_base
neg <- z[z$delta<0,]; pos <- z[z$delta>0,]
# Sem um identificador de pareamento da emenda, não é metodologicamente válido
# afirmar qual cancelamento financiou qual acréscimo. Exportamos movimentos separados.
out <- rbind(data.frame(origem=neg$area_base,destino="Acréscimos a identificar",instrumento=neg$instrumento_comparada,autor="Não identificado",cancelado=-neg$delta,acrescido=0,risco="Médio"),data.frame(origem="Cancelamentos a identificar",destino=pos$area_comparada,instrumento=pos$instrumento_comparada,autor="Não identificado",cancelado=0,acrescido=pos$delta,risco="Médio"))
out$id <- seq_len(nrow(out)); out <- out[,c("id","origem","destino","instrumento","autor","cancelado","acrescido","risco")]
jsonlite::write_json(out,args[3],pretty=TRUE,auto_unbox=TRUE,na="null")
