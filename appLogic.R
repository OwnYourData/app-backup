# application specific logic
# last update: 2017-02-13

source('srvDateselect.R', local=TRUE)
source('srvEmail.R', local=TRUE)
source('srvScheduler.R', local=TRUE)

# any record manipulations before storing a record
appData <- function(record){
        record
}

getRepoStruct <- function(repo){
        appStruct[[repo]]
}

repoData <- function(repo){
        data <- data.frame()
        app <- currApp()
        if(length(app) > 0){
                url <- itemsUrl(app[['url']],
                                repo)
                data <- readItems(app, url)
        }
        data
}

# anything that should run only once during startup
appStart <- function(){
        app <- currApp()
        if(length(app) > 0){
                url <- itemsUrl(app[['url']],
                                backupStatusKey)
                retVal <- readItems(app, url)
                backupActiveStatus <- TRUE
                if((nrow(retVal) > 1) | (nrow(retVal) == 0)){
                        deleteRepo(app, url)
                        item <- list(active         = backupActiveStatus,
                                     '_oydRepoName' = 'Backup Status')
                        writeItem(app, url, item)
                }
                if(nrow(retVal) == 1){
                        backupActiveStatus <- retVal$active
                }
                if(backupActiveStatus){
                        updateCheckboxInput(session, 'backup_active',
                                            value = TRUE,
                                            label = paste(appTitle, '(aktiv)'))
                } else {
                        updateCheckboxInput(session, 'backup_active',
                                            value = FALSE,
                                            label = paste(appTitle, '(inaktiv)'))
                }
        }
}

observeEvent(input$backup_active, {
        app <- currApp()
        if(length(app) > 0){
                backupActiveStatus <- TRUE
                if(input$backup_active){
                        updateCheckboxInput(session, 'backup_active',
                                            label=paste(appTitle, '(aktiv)'))
                } else {
                        updateCheckboxInput(session, 'backup_active',
                                            label=paste(appTitle, '(inaktiv)'))
                        backupActiveStatus <- FALSE
                }
                url <- itemsUrl(app[['url']],
                                backupStatusKey)
                retVal <- readItems(app, url)
                if(nrow(retVal) > 1){
                        deleteRepo(app, url)
                        retVal <- data.frame()
                }
                item <- list(active         = backupActiveStatus,
                             '_oydRepoName' = 'Backup Status')
                if(nrow(retVal) == 1){
                        updateItem(app, url, item, retVal$id)
                }
                if(nrow(retVal) == 0){
                        writeItem(app, url, item)
                }
        }
})

output$backupList <- DT::renderDataTable({datatable({
        data <- currData()
        if(nrow(data) > 0){
                data$myDat <- as.character(as.POSIXct(
                        as.numeric(data$timestamp), origin='1970-01-01'))
                rownames(data) <- 1:nrow(data)
                data <- data[, c('myDat', 'link'), drop = FALSE]
                data$link <- lapply(data$link, function(x) {
                        paste0('<a href="', x, '">', x, '</a>')
                })
                colnames(data) <- c('Zeit', 'Link zum Download')
                data
        } else {
                data.frame()
        }
}, options = list(
        language = list(
                url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/German.json')
)
)}, escape = FALSE)

output$backupTables <- renderTable({
        data <- data.frame(c('Listen', 'Datensätze'))
        colnames(data) <- c('Tabelle')
        data
})
