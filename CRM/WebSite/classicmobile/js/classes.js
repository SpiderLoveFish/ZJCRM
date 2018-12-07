//案例类型
$.ajax({
    type: "POST",
    url: "../../data/website.ashx?Action=combo_para&parentid=19&rnd=" + Math.random(),
     //contentType: "application/json; charset=utf-8",
    //dataType: "json",
    success: function (result) {
        var obj = eval(result);
       //alert(JSON.stringify(obj))
        //$('#ulallx').remove();//事先存好了对象就方便删除了
      var  item = "<li data-value='0'>全部</li>"
        $('.ulallx').append(item);
        $.each(obj, function (i, data) {

            item = "<li data-value='" + data['id'] + "'>" + data['text'] +"</li>" ;
            $('.ulallx').append(item);
        });
    },
    error: function (XMLHttpRequest, textStatus, errorThrown) {
        alert("案例类型请求失败！~~");
    }
});
//设计师
$.ajax({
    type: "POST",
    url: "../../data/website.ashx?Action=combo_person",
    //contentType: "application/json; charset=utf-8",
    //dataType: "json",
    success: function (result) {
        var obj = eval(result);
        //  alert(JSON.stringify(obj))
        //$('#ulallx').remove();//事先存好了对象就方便删除了
       
        $.each(obj, function (i, data) {

         var   item = "<li data-value='" + data['id'] + "'>" + data['text'] + "</li>";
            $('.ulsjs').append(item);
        });
    },
    error: function (XMLHttpRequest, textStatus, errorThrown) {
        alert("设计师请求失败！~~");
    }
});

//装修风格
$.ajax({
    type: "POST",
    url: "../../data/website.ashx?Action=combo_para&parentid=10",
    //contentType: "application/json; charset=utf-8",
    //dataType: "json",
    success: function (result) {
        var obj = eval(result);
        //  alert(JSON.stringify(obj))
        //$('#ulallx').remove();//事先存好了对象就方便删除了

        $.each(obj, function (i, data) {

            var item = "<li data-value='" + data['id'] + "'>" + data['text'] + "</li>";
            $('.ulzxfg').append(item);
        });
    },
    error: function (XMLHttpRequest, textStatus, errorThrown) {
        alert("装修风格请求失败！~~");
    }
});
