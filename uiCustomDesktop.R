# top-level framework for desktop version
# last update:2016-10-29

source('uiStart.R')
source('uiCustomApp.R')
source('uiMenu.R')
source('uiFooter.R')

uiCustomDesktop <- function(){
        tagList(
                # Code for initial "Wait"-Animation
                # tags$head(tags$script(src='http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js')),
                # tags$head(tags$link(rel='stylesheet', type='text/css', href='init_anim.css')),
                # tags$div(class='init-animation'),
                uiInit(),
                uiStart(),
                navbarPage(
                        uiOutput('hdrImageLinkDesktop'),
                        id='mainPage',
                        selected = appName,
                        collapsible=TRUE,
                        inverse=FALSE,
                        windowTitle=paste0(appTitle, ' | OwnYourData'),
                        tabPanel(HTML(paste0('hidden', 
                                             '</a></li>',
                                             '<li><a href="', helpUrl, '"><i class="fa fa-question-circle" aria-hidden="true"></i> Hilfe</a></li>',
                                             '<li><a id="returnPIAlink" href="#">zum Datentresor'))
                        ),
                        tabPanel(appTitle,
                                 value = appName,
                                                tagList(
                                                        bsAlert('urlStatus'),
                                                        bsAlert('piaStatus'),
                                                        bsAlert('taskInfo')
                                 ),
                                 uiCustomApp()
                        ),
                        navbarMenu(icon('cog'),
                                   uiMenu()
                        ),
                        footer=uiFooter()
                )
        )
}