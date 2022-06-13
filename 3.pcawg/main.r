# Load several datasets at once
pcawg_samples = list.files('data', full.names = TRUE) %>%
  lapply(readRDS)

require(CNAqc)

# Initialize CNAqc object
pcawg_samples = lapply(pcawg_samples,
                       function(x){
                         CNAqc::init(
                           x$mutations,
                           x$cna %>% dplyr::filter(CCF == 1), # clonal CNAs
                           x$metadata$purity,
                           ref = 'hg19',
                           sample = x$metadata$sample
                         )
                       })

# Fast data QC
pcawg_samples = pcawg_samples %>%
  lapply(analyze_peaks, purity_error = 0.025)

saveRDS(pcawg_samples, "CNAqc.rds")

pdf("CNAqc.pdf", width = 12, height = 4)
pcawg_samples %>% lapply(plot_peaks_analysis)
dev.off()

pdf("CNAqc_complex.pdf", width = 12, height = 4)
pcawg_samples %>% lapply(plot_peaks_analysis, what = 'complex')
dev.off()

# Mobster for diploid

require(mobster)

mobster_fits = lapply(pcawg_samples,
                      function(x){

                        if(!("1:1" %in% (x$n_karyotype %>% names))) return(NULL)

                        vafs = x %>%
                          subset_by_segment_karyotype('1:1') %>%
                          subsample(N = 5000) %>%
                          Mutations(cna = 'clonal', type = 'SNV') %>%
                          filter(VAF > 0.05, VAF < 0.75)

                        if((vafs %>% nrow) == 0 | is.null(vafs)) return(NULL)

                        mobster_fit(vafs, auto_setup = 'FAST')
                      }
  )

saveRDS(mobster_fits, "mobster.rds")

pdf("mobster.pdf", width = 6, height = 6)
mobster_fits %>%
  lapply(function(x) if(!is.null(x)) x$best %>% plot)
dev.off()



