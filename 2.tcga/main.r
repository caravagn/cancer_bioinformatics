input = readRDS("./tcga_purity_example.rds")

# See the inputs
input %>% print()

# Fits all samples - use functional programming (lapply)
fits = lapply(
  names(input$purity_options), 
  function(x) {
    init(
      input$snvs, 
      input$cna, 
      input$purity_options[x], # Here is the tool-specific purity in input
      ref = 'GRCh38'
      ) %>% 
      analyze_peaks(purity_error = 0.025)
  })

names(fits) = names(input$purity_options)

# Plots all samples - as above
plots =  lapply(
  fits %>% names, 
  function(x) plot_peaks_analysis(fits[[x]], empty_plot = FALSE) + labs(title = x)
  )

# One figure (assembly)
ggpubr::ggarrange(plotlist =plots, nrow = 1)
