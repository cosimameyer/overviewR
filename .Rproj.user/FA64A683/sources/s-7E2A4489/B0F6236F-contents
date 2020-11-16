# Add new names to Train.csv

train <- readr::read_csv("~/Downloads/correlaid-zindi/train_full.csv")
# train_int2 <- readr::read_csv("~/Downloads/correlaid-zindi/labels_new.csv")
train2 <- readr::read_csv("~/Downloads/correlaid-zindi/train_full.csv")
train3 <- readr::read_csv("~/Downloads/correlaid-zindi/train_full.csv")
train4 <- readr::read_csv("~/Downloads/correlaid-zindi/train_full.csv")
train5 <- readr::read_csv("~/Downloads/correlaid-zindi/train_full.csv")

# Add names
# Speed
train2 %<>% 
  mutate(interim1 = stringr::str_replace(fn, "audio_files/", ""),
         interim2 = stringr::str_replace(interim1, "audio_train/", ""),
         interim3 = stringr::str_replace(interim2, ".wav", ""),
         fn = paste0("audio_train/", "aug-speed-", interim3, ".wav")) %>% 
  select(-c(interim1, interim3, interim2))

# Shift
train3 %<>% 
  mutate(interim1 = stringr::str_replace(fn, "audio_files/", ""),
         interim2 = stringr::str_replace(interim1, "audio_train/", ""),
         interim3 = stringr::str_replace(interim2, ".wav", ""),
         fn = paste0("audio_train/", "aug-shift-", interim3, ".wav")) %>% 
  select(-c(interim1, interim3, interim2))

# Noise
train4 %<>% 
  mutate(interim1 = stringr::str_replace(fn, "audio_files/", ""),
         interim2 = stringr::str_replace(interim1, "audio_train/", ""),
         interim3 = stringr::str_replace(interim2, ".wav", ""),
         fn = paste0("audio_train/", "aug-noise-", interim3, ".wav")) %>% 
  select(-c(interim1, interim3, interim2))

# Pitch
train5 %<>% 
  mutate(interim1 = stringr::str_replace(fn, "audio_files/", ""),
         interim2 = stringr::str_replace(interim1, "audio_train/", ""),
         interim3 = stringr::str_replace(interim2, ".wav", ""),
         fn = paste0("audio_train/", "aug-pitch-", interim3, ".wav")) %>% 
  select(-c(interim1, interim3, interim2))

# Bring them together
# All train data (except the new train data)
train_full <- rbind(train, train2, train3, train4, train5)

# Only the augmented train data
train_augmented <- rbind(train2, train3, train4, train5)
write.csv(train_augmented, file="train_augmented_data.csv")
