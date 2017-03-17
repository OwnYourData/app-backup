# layout for the body of the app
# last update:2016-10-06

source('appStatus.R')
source('appSource.R')
source('appStore.R')

uiCustomApp <- function(){
        fluidRow(
                column(1),
                column(10,
                       tags$div(class='panel panel-default',
                                tags$div(class='panel-heading',
                                         style='padding:0',
                                         tags$h3(class='panel-title pull-left', 
                                                 div(style='display:inline-block',
                                                     tags$img(src='app_logo.png', style='width: 58px; margin-left: -70px; margin-top: -30px; margin-bottom: -98px'),
                                                     checkboxInput('backup_active', label = paste(appTitle, '(aktiv)'), value = TRUE, width = '320px')
                                                 ),
                                                 style='font-size:200%;padding:0 15px;margin:-30px 0 -5px 30px'),
                                         tags$button(id='buttonStore', type='button',
                                                     class='btn btn-default action-button pull-right',
                                                     style='padding:15px; border:0; border-radius:0; background-color:#f5f5f5',
                                                     icon('table'), 'Gesammelte Daten'),
                                         tags$button(id='buttonSource', type='button',
                                                     class='btn btn-default action-button pull-right',
                                                     style='padding:15px; border:0; border-radius:0; background-color:#f5f5f5; border-left-color: #45b79e; border-left-width: 1px; border-left-style: solid; border-right-color: #45b79e; border-right-width: 1px; border-right-style: solid',
                                                     icon('cloud-download'), 'Datenquellen'),
                                         tags$button(id='buttonVisual', type='button',
                                                     class='btn btn-default action-button pull-right',
                                                     style='padding:15px; border:0; border-radius:0; background-color:#45b79e; border-left-color: #45b79e; border-left-width: 1px; border-left-style: solid; color: white',
                                                     icon('line-chart'), 'Auswertungen'),
                                         tags$div(class='clearfix')
                                         
                                ),
                                tags$div(class='panel-body',
                                         conditionalPanel(
                                                 condition = "output.displayVisual != ''",
                                                 appStatus()
                                         ),
                                         conditionalPanel(
                                                 condition = "output.displaySource != ''",
                                                 appSource()
                                         ),
                                         conditionalPanel(
                                                 condition = "output.displayStore != ''",
                                                 appStore()
                                         )
                                )
                       )
                )
        )
}
