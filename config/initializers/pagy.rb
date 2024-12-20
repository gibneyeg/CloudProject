require 'pagy/extras/bootstrap'
require 'pagy/extras/overflow'

#default number of items per page to 10
Pagy::DEFAULT[:items] = 10
Pagy::DEFAULT[:overflow] = :last_page
