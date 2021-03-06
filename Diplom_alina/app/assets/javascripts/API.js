 API = {

     change_student_by_date: function(params, callback, err){
       API.post('/state_by_date.json', params, callback, err);
     },

     create_year: function (params, callback, err) {
         API.post('/create_year', params, callback, err);
     },

     create_type_subdivision : function(params, callback, err) {
       API.post('/create_type_subdivision', params, callback, err);
     },

     create_subdivision : function(params, callback, err) {
         API.post('/create_subdivision', params, callback, err);
     },

     download_subdivisions : function(params, callback, err) {
         API.post('/subdivisions_for_select', params, callback, err);
     },

     create_group : function (params, callback, err) {
       API.post('/groups', params, callback, err);
     },

     change_active_role : function (params, callback, err) {
         API.post('/change_active_role', params, callback, err);
     },

     create_role: function (params, callback, err) {
         API.post('/create_role', params, callback, err);
     },
     
     load_plans_by_speciality_id : function(params, callback, err) {
         API.post('/load_plans_by_speciality_id', params, callback, err);
     },
     
     load_term_by_year_id: function (params, callback, err) {
         API.post('/load_term_by_year_id', params, callback, err);
     },

     load_groups_by_subdivision_id: function(params, callback, err) {
         API.post('/load_groups_by_subdivision_id', params, callback, err);
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