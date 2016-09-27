/**
 * 
 */

$.ajaxPrefilter(function(options, originalOptions, jqXHR) {
    var token;
    if (!options.crossDomain) {
      token = $('meta[name="_csrf"]').attr('content');
      if (token) {
        return jqXHR.setRequestHeader('X-CSRF-Token', token);
      }
    }
});




