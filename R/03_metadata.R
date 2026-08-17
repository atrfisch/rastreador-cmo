if(!requireNamespace("jsonlite",quietly=TRUE)) install.packages("jsonlite",repos="https://cloud.r-project.org")
meta <- list(fonte="SIOP / orcamentoBR",exercicio=as.integer(Sys.getenv("EXERCICIO",format(Sys.Date(),"%Y"))),atualizado_em=format(Sys.time(),"%d/%m/%Y %H:%M"),demonstrativo=FALSE)
jsonlite::write_json(meta,"public/data/metadata.json",pretty=TRUE,auto_unbox=TRUE)
