 API = {


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
             dataType: "json",
             url: url,
             data: params,
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