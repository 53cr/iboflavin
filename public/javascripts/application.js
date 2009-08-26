// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
    $('#post_content').wysiwyg({ justifyLeft   : { visible : true },
                                 justifyCenter : { visible : true },
                                 justifyRight  : { visible : true },
                                 justifyFull   : { visible : true },
                                 insertOrderedList    : { visible : true },
                                 insertUnorderedList  : { visible : true },
                                 insertHorizontalRule : { visible : true }
                               });
})();
