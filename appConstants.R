# global constants available to the app
# last update:2016-01-17

# constants required for every app
appName <- 'backup'
appTitle <- 'Datensicherung'
app_id <- 'eu.ownyourdata.backup'
helpUrl <- 'https://www.ownyourdata.eu/apps/backup'

# definition of data structure
currRepoSelect <- ''
appRepos <- list(Datensicherung = 'eu.ownyourdata.backup',
                 Verlauf = 'eu.ownyourdata.backup.log')
appStruct <- list(
        Datensicherung = list(
                fields      = c('timestamp', 'name', 'link'),
                fieldKey    = 'timestamp',
                fieldTypes  = c('timestamp', 'string', 'string'),
                fieldInits  = c('empty', 'empty', 'empty'),
                fieldTitles = c('Zeit', 'Datei', 'Link'),
                fieldWidths = c(150, 250, 300)),
        Verlauf = list(
                fields      = c('date', 'description'),
                fieldKey    = 'date',
                fieldTypes  = c('date', 'string'),
                fieldInits  = c('empty', 'empty'),
                fieldTitles = c('Datum', 'Text'),
                fieldWidths = c(150, 450)))

# Version information
currVersion <- "0.3.0"
verHistory <- data.frame(rbind(
        c(version = "0.3.0",
          text    = "erstes Release")
))

# app specific constants
backupStatusKey <- 'eu.ownyourdata.backup.status'
