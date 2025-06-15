# Redirect old static projects URL to the alias domain
# to avoid Rails router to swallow them and render 404.
# !!! Do not remove these URLs, they are mandatory for
# compatibilty purposes !!!
get '/cheque', to: redirect('https://monero-map.org/cheque/')
get '/crypto_box', to: redirect('https://monero-map.org/crypto_box/')
get '/epicerie', to: redirect('https://monero-map.org/epicerie/')
get '/map.html', to: redirect('/en/map')
get '/c', to: redirect(QueryRedirector.new('https://monero-map.org/c/'))

# English
get '/en/accounting', to: redirect('/en/tutorials/accounting')
get '/en/merchants/new', to: redirect('/en/merchant_proposals/new')
get '/frequently-asked-questions', to: redirect('/en/frequently-asked-questions')
get '/glossary', to: redirect('/en/glossary')
get '/stats', to: redirect('/en/stats')
get '/map/embed', to: redirect('/en/map/embed')

# French
get '/les-marchands/:id', to: redirect('/commercants/%{id}')
get '/les-groupes-locaux', to: redirect('/groupes-locaux')
get '/les-projets', to: redirect('/projets')
get '/les-projets/:id', to: redirect('/projets/%{id}')
get '/comptabilite', to: redirect('/tutoriels/accounting')
get '/commercants/new', to: redirect('/merchant_proposals/new')

# Spanish
get '/es/los-comerciantes/:id', to: redirect('/es/comerciantes/%{id}')
get '/es/los-grupos-locales', to: redirect('/es/grupos-locales')
get '/es/los-proyectos', to: redirect('/es/proyectos')
get '/es/los-proyectos/:id', to: redirect('/es/proyectos/%{id}')
get '/es/contabilidad', to: redirect('/es/tutoriales/accounting')
get '/es/comerciantes/new', to: redirect('/es/merchant_proposals/new')
