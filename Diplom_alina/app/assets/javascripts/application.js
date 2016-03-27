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
//= require bootstrap
//= require bootstrap-datepicker
//= require fancybox
//= require turbolinks
//= require_tree .



var CNGNT =  {

    init: function() {
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

        $('.element-line-history').click(
            function() {
                const student_id = $(this).parent().attr('student_id');
                const date = $(this).attr('data-title');
                const element_history = $('.element-line-history');
                for (var i = 0; i < element_history.size();i++ )
                {
                    element_history.eq(i).removeClass('active');
                }
                $(this).addClass('active');
                API.change_student_by_date({'student_id' : student_id, 'date':date},
                    function(resp) {
                        $('.sys-date-actual').text(resp.date_actual);
                        //photo
                        $('a.fancybox').attr('href', resp.photo.url);
                        $('a.fancybox').find('img').attr('src', resp.photo.url_medium);
                        //passport
                        const tr_arr = $('table[name=sys-student-info-1]').find('td');
                        const addr2 =  $('table[name=sys-student-info-2]').find('td');
                        tr_arr.eq(1).text(resp.passport.first_name);
                        tr_arr.eq(3).text(resp.passport.second_name);
                        tr_arr.eq(5).text(resp.passport.last_name);
                        tr_arr.eq(7).text(resp.passport.birthday.split('T')[0]);
                        tr_arr.eq(9).text(resp.passport.birthday_city);
                        tr_arr.eq(11).text(resp.passport.sex == 'm' ? 'Мужской' : 'Женский');
                        //student
                        tr_arr.eq(13).text(resp.student.ducket_number);
                        tr_arr.eq(15).text(resp.student.ducket_date.split('T')[0]);
                        // again passport
                        tr_arr.eq(17).text(resp.passport.series);
                        tr_arr.eq(19).text(resp.passport.number);
                        tr_arr.eq(21).text(resp.passport.passport_issued);
                        tr_arr.eq(23).text(resp.passport.code_subdivision);
                        tr_arr.eq(25).text(resp.passport.date_extradition);
                        //addresses

                        addr2.eq(1).text(resp.p_address);
                        addr2.eq(3).text(resp.r_address);
                        addr2.eq(5).text(resp.f_address);


                    },
                    function(resp){
                    });
                return false;
            }
        );

        $('.datepicker').datepicker();

        $("a.fancybox").fancybox();

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

        $('.navbar-toggle').click(function() {

        });

        $('a.navbar-toggle').click(function() {
            const sidebar = $('.sidebar-nav');
            if(sidebar.hasClass('collapse')) {
                $('ul.nav.navbar-nav').css('min-height', 0);
                sidebar.removeClass('collapse');
            } else {
                sidebar.addClass('collapse');
                $('ul.nav.navbar-nav').css('min-height', '768px');
            }
            return;
        });
    }
};

$(document).ready(CNGNT.init());

//$(document).on('page:load', ready());
//
//$(document).on('page:change', ready());
