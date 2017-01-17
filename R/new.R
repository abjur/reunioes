#' Abrir template
#'
#' Abrir template de reunioes.
#'
#' @param nome Titulo da reuniao.
#' @param data data em formato YYYYMMDD. Default data atual.
#'
#' @export
new_meet <- function(nome, data = format(Sys.Date(), '%Y%m%d')) {
  f <- system.file('template.Rmd', package = 'reunioes')
  data <- format(lubridate::ymd(data), '%Y%m%d')
  fout <- sprintf('%s_%s.Rmd', data, gsub('[^a-z0-9]+', '_', tolower(nome)))
  rmarkdown::render(f, rmarkdown::md_document('markdown'),
                    output_file = fout, output_dir = './', quiet = TRUE)
  utils::file.edit(fout)
}
