// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootstrap-datepicker
//= require_tree .



var ready = function () {
    $("li.dropdown").on('click',
        function() {
            if ($(this).attr('class').length == 8) {
                $(this).attr('class', 'dropdown open');
            } else {
                $(this).attr('class', 'dropdown');
            }
            return;
        }
    );

    $('.datepicker').datepicker();

    //$('a[name=btn-save-student]').click(function(){
    //    const fields = $("form").serialize();
    //    alert(fields+" ");
    //    API.post("/students.json", fields)
    //});

    $("ul#side-menu > li").on('click', function(){
            if ($(this).attr('class').length == 0) {
                $(this).find('ul.nav-second-level').addClass('in');
                $(this).attr('class', 'active');
            } else {
                $(this).find('ul.nav-second-level').attr('class', 'nav nav-second-level collapse');
                $(this).attr('class', '');
            }
            return;
    });

    $(window).bind("load resize", function() {
        topOffset = 50;
        width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-collapse').addClass('collapse');
            topOffset = 100; // 2-row-menu
        } else {
            $('div.navbar-collapse').removeClass('collapse');
        }

        height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
        height = height - topOffset;
        if (height < 1) height = 1;
        if (height > topOffset) {
            $("#page-wrapper").css("min-height", (height) + "px");
        }
    });


};

$(document).ready(ready());

//$(document).on('page:load', ready());
//
//$(document).on('page:change', ready());
