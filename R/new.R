#' Abrir template
#'
#' Abrir template de reunioes.
#'
#' @param nome Titulo da reuniao.
#' @param dir Pasta onde os arquivos serão salvos.
#' @param data data em formato YYYYMMDD. Default data atual.
#'
#' @export
new_meet <- function(nome, dir = 'reunioes',
                     data = format(Sys.Date(), '%Y%m%d')) {
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  f <- system.file('template.Rmd', package = 'reunioes')
  data <- format(lubridate::ymd(data), '%Y%m%d')
  nm <- gsub('[^a-z0-9]+', '_', tolower(nome))
  fout <- sprintf('%s/%s_%s.Rmd', dir, data, nm)
  rmarkdown::render(f, rmarkdown::md_document('markdown'),
                    output_file = fout, output_dir = dir, quiet = TRUE)
  if (interactive()) {
    rstudioapi::navigateToFile(fout)
  } else {
    utils::file.edit(fout)
  }
}
