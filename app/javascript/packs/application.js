// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
import "../controllers"

Rails.start()
ActiveStorage.start()

import "packs/tourney/tourney-card-advanced"
import "packs/navbar"

require("trix")
require("@rails/actiontext")
// LINK ::    https://osu.ppy.sh/community/matches/89309929
