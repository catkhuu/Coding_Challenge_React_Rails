'use strict'

$(document).ready(function() {
   $('input#input_text, textarea#textarea1').characterCounter();
   $('#textarea1').val('New Text');
   $('#textarea1').trigger('autoresize');
 });
