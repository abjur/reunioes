#' Enviar email ABJ
#'
#' Envia um e-mail com base em arquivo Rmd de reuniões.
#'
#' @param arq Arquivo Rmd.
#' @param from quem enviou o e-mail? Default jtrecenti at abj.org.br.
#' @param dests vetor de emails dos destinatários. Default reunioes at abj.org.br.
#'
#' @import gmailr
#' @importFrom magrittr %>%
#' @export
enviar <- function(arq, from = 'jtrecenti@abj.org.br', dests = c('reunioes@abj.org.br')) {
  html_frag <- rmarkdown::html_fragment()
  arq_html <- rmarkdown::render(arq, output_format = html_frag, quiet = TRUE, encoding = "UTF-8")
  nm <- unlist(stringr::str_split(gsub('\\.Rmd', '', arq), '_'))
  nm <- tools::toTitleCase(paste(nm, collapse = ' '))
  mm <- gmailr::mime() %>%
    gmailr::from(from) %>%
    gmailr::to(dests) %>%
    gmailr::subject(nm) %>%
    gmailr::html_body(shiny::HTML(readr::read_file(arq_html)))
  draft <- gmailr::create_draft(mm)
  gmailr::send_draft(draft)
}
