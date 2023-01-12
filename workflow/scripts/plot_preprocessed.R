library(tidyverse, suppressPackageStartupMessages())
library(ggtext)

stats1 <- read_table("data/stats1/seqkit_stats.txt", show_col_types = F) %>% 
  mutate(file = str_replace_all(file, ".*/", "")) %>% 
  select(file, original = num_seqs)

stats2 <- read_table("data/stats2/seqkit_stats.txt", show_col_types = F) %>% 
  mutate(file = str_replace_all(file, ".*/", "")) %>% 
  select(file, trimmed = num_seqs)

stats3 <- read_table("data/stats3/seqkit_stats.txt", show_col_types = F) %>% 
  mutate(file = str_replace_all(file, ".*/", "")) %>% 
  select(file, decontaminated = num_seqs)

read_stats <- inner_join(stats1, stats2, by = "file") %>% 
  inner_join(., stats3, by = "file") %>% 
  mutate(strand = ifelse(str_detect(file, "_1"), "foward", "reverse"), .before=original) %>%
  pivot_longer(cols = -c(file, strand), names_to = "variable", values_to = "num_seqs") %>% 
  mutate(variable = factor(variable),
         variable = fct_reorder(variable, num_seqs, .desc=TRUE))

saveRDS(read_stats, "RDataRDS/read_stats.rds")

readRDS("RDataRDS/read_stats.rds") %>% 
  ggplot(aes(x = strand, y = num_seqs/1000, fill = variable)) +
  geom_col(position = "dodge") +
  labs(x = "Read Strand", y = "Number of Reads (thousand)", fill = "Preprocess") +
  theme_classic() +
  theme(axis.text.x = element_markdown(),
        legend.text = element_text(face = NULL),
        legend.key.size = unit(12, "pt")) + 
  scale_y_continuous(expand = c(0, 0))