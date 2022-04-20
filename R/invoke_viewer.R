#' Invoke the RStudio Data Viewer on Highlighted Text
#'
#' @details This function will invoke the RStudio Data Viewer on highlighted text. Unlike the built-in shortcut F2 (Go To Definition), this function will additionally accept piped sequences of commands or function calls that return a result viewable in the data viewer. After installing the package, go to "Modify Keyboard Shortcuts" and set a shortcut of your choice for the name "Invoke Viewer".
#'
#' @return NULL
#' @export
invoke_viewer <- function () {
  ctx <- rstudioapi::getActiveDocumentContext()

  selection <- ctx$selection[[1]]$text
  view_command <- paste0("View(", selection, ")")

  tryCatch(
    eval(parse(text = view_command)),
    error = function(e) {
      stop(paste0("Cannot pass highlighted text to the data viewer. Attempted function call: ", view_command))
    }
  )
}
