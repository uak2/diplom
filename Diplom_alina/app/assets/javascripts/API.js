 API = {

     change_student_by_date: function(params, callback, err){
       API.post('/state_by_date.json', params, callback, err);
     },

     create_year: function (params, callback, err) {
         API.post('/create_year', params, callback, err);
     },

     //=====================  AJAX  ============================
     put: function (url, params, callback, err) {
         $.ajax({
             type: "PUT",
             dataType: "json",
             url: url,
             data: params,
             time: 30000,
             success: callback,
             error: err
         });
         return false;
     },

     del: function (url, params, callback, err) {
         $.ajax({
             type: "DELETE",
             dataType: "json",
             url: url,
             data: params,
             time: 30000,
             success: callback,
             error: err
         });
     },

     post: function (url, params, callback, err) {
         $.ajax({
             type: "POST",
             url: url,
             data: params,
             dataType: "json",
             time: 30000,
             success: callback,
             error: err
         });
     },

     get: function (url, params, callback, err) {
         $.ajax({
             type: "GET",
             dataType: "json",
             url: url,
             data: params,
             time: 30000,
             success: callback,
             error: err
         });
     }

 };