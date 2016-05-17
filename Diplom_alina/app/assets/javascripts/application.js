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
        $('li.dropdown').on('click',
            function() {
                if ($(this).attr('class').length == 8) {
                    $(this).attr('class', 'dropdown open');
                } else {
                    $(this).attr('class', 'dropdown');
                }
                return false;
            }
        );

        $('.element-line-history').click(
            function() {
                const student_id = $(this).parent().attr('student_id');
                const date = $(this).attr('data-title');
                const element_history = $(".element-line-history");
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
                        tr_arr.eq(25).text(resp.passport.date_extradition.split('T')[0]);
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

        $('.datepicker').datepicker({showButtonPanel: true});

        $("a.fancybox").fancybox();

        $("#start_term").change(function() {
            CNGNT.switch_access_btn_term();
            return false;
        });

        $("#end_term").change(function() {
            CNGNT.switch_access_btn_term();
            return false;
        });


        $('.sys-year-btn-add').on('click', function () {

            const start_year = $('input[name=start_year]').val();
            if (start_year == '') {
                $('input[name=start_year]').css('border-color','red');
            }

            const end_year = $('input[name=end_year]').val();
            if (end_year == '') {
                $('input[name=end_year]').css('border-color','red');
            }

            if(start_year == '' || end_year == '') return false;


            API.create_year({'start_year':start_year, 'end_year':end_year},
                function (resp) {
                    if (resp.status == 'ok') {
                        const select_year = $('select[name=year]');
                        select_year.append('<option value="' + resp.id + '">' + resp.data + '</option>');
                        $('.msg-create > i').css('opacity', 1.0);
                        $('.msg-create > i').animate({opacity: 0}, 2000);
                        return false;
                    }
                    alert('Возникли проблемы. Обратитесь к сисетмному администратору.');
            }, function (resp) {

            });

        });

        $('.sys-save-tsubdivision').on('click', function () {
           const subdivision_type_name = $('input[name=type_title]').val();
            API.create_type_subdivision({'type_title':subdivision_type_name},
            function (resp) {
                const selectors = $('select[name=type_subdivision]');
                for(var i = 0; i < selectors.length; i++) {
                    $(selectors[i]).append('<option value="' + resp.type.id + '">' + resp.type.title + '</option>');
                }
                $('input[name=type_title]').val('');
                $('.msg-create > i').css('opacity', 1.0);
                $('.msg-create > i').animate({opacity: 0}, 2000);
                return false;
            }, function (code) {
                    alert(code);
                });
        });

        // Загрузка блока подразделений в форме создания группы.
        $('.sys-add-many-subdivision').on('click', function () {
            const bobber = $('.float-subdivision');
            const orig = $('select[name=hide-sybdivision]').parent();
            const tmp = orig.clone();
            tmp.find('select').attr('name', 'subdivision');
            const selector = tmp.find('select');
            API.download_subdivisions({},
                function(resp) {
                    for (var i = 0; resp.length; i++){
                        selector.append('<option value="' + resp[i].id + '">' + resp[i].institution +"(" + resp[i].chairisting+ ")" + '</option>');
                    }
                }, function (resp) {
                alert('Произошла внутренняя ошибка. Обратитесь к администратору.');
            });
            bobber.parent().append(tmp);
        });

        //создание группы с дальнейшим редиректом
        $('.sys-save-group').click(function() {
            const subdivisions = [];
            const selectors = $('select[name=subdivision]');
            const name = $('#group_name').val();
            for (var i = 0; i < selectors.length; i++) {
                subdivisions[i] = $(selectors[i]).val();
            }
            API.create_group({'subdivisions': subdivisions, 'group' : {'name':name} },
                function (resp) {
                    var url = "http://localhost:3000/groups";
                    $(location).attr('href',url);
                }, function(code) {

                });
        });


        $('.sys-save-subdivision').on('click', function() {
            const type_id = $('select[name=type_subdivision]').val();
            const institution = $('input[name=institution]');
            const chairisting = $('input[name=chairisting]');
            API.create_subdivision({'type_id' : type_id, 'institution': institution.val(), 'chairisting':chairisting.val()},
            function(resp) {
                if(resp.status == 'ok') {
                    const selector = $('select[name=subdivision]');
                    selector.append('<option value="' + resp.subdivision.id + '">' + resp.subdivision.chairisting + "("+ resp.subdivision.institution+")" + '</option>');
                    institution.val('');
                    chairisting.val('');
                    $('.msg-create_1 > i').css('opacity', 1.0);
                    $('.msg-create_1 > i').animate({opacity: 0}, 2000);
                    return false;
                }
                alert(resp.status);
            }, function(code) {


                });
        });


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
    },

    switch_access_btn_term:function () {
        if  ($("#end_term").val() <= $("#start_term").val()) {
            $("#start_term").css('border-color', 'red');
            $("#end_term").css('border-color', 'red');
            $('input[name=commit]').attr('disabled', 'true');
        } else {
            $("#start_term").css('border-color', '');
            $("#end_term").css('border-color', '');
            $('input[name=commit]').attr('disabled', null);
        }
        return;
    }
};

$(document).ready(CNGNT.init());
