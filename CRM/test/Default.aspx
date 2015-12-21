<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Spider.Web.Default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>CESHI </title>
    <script type="text/javascript" src="JS/jquery-1.8.0.min.js"></script>
        <script type="text/javascript" src="JS/jtopo-0.4.8-min.js"></script>
      <script type="text/javascript" src="JS/spider.js"></script>
    <script type="text/javascript">
        var n1, n2; var nodes = [];
        var findstage;
        $(document).ready(function () {
            $.ajax({
                type: "GET",
                url: "Default.aspx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n = 0; n < obj.TEST1.length; n++) {
                   // for (var n in obj.TEST1) {
                        if (obj.TEST1[n] == "null" || obj.TEST1[n] == null) {
                            alert(n);
                            obj.TEST1[n] = "";
                        }
                        else {
                            
                            switch(n)
                            {
                                case 0:
                                    
                                     n1=addNode(obj.TEST1[n].name, obj.TEST1[n].x, obj.TEST1[n].y,"");
                                     nodes.push(n1);
                                     break;
                                case 1:
                                    
                                     n2=addNode(obj.TEST1[n].name, obj.TEST1[n].x, obj.TEST1[n].y,"");
                                     n2.alarm = 'Warrning';
                                     n2.alarmColor = '255,0,0';
                                     n2.alarmAlpha = 0.9;
                                     nodes.push(n2);
                                     break;
                                default:break;
                            }
                           

                            
                            // var Link = addLink(n1,n2);
                        }
                        
                    }
                    for (var n = 0; n < obj.TEST2.length; n++) {
                        //var l = addLink(n1, n2);
                        {
                            var link = newFoldLink(nodes[obj.TEST2[n].x], nodes[obj.TEST2[n].y], 'FoldLink', 'vertical');
                            //  var link = newFoldLink(n2, n1, 'FoldLink', 'vertical', 5);
                        }
                    }
                   // alert(obj.TEST1   )
                    //var node1 = myNode('自定义', 355, 151);
                    //var node1 = myNode('自定义', 445, 151);
                },
                error: function (e) {
                    alert(e);
                }
            });
            var stage = new JTopo.Stage(document.getElementById('canvas'));
            findstage=stage;
            var scene = new JTopo.Scene();
           // scene.backgroundColor = '255,0,0';
          //  scene.background = './img/bg.jpg';
            stage.add(scene);
            function addNode(text, x, y) {
                var node = new JTopo.Node(text);
                node.borderRadius = 5;
                var text = position = text;
                // node.textPosition = position;
                node.fontColor = "204,204,204";
              
                //node.setImage('./img/statistics/' + img, true);
                node.setLocation(x, y);
                scene.add(node);
                return node;
            }

            // 折线
            function newFoldLink(nodeA, nodeZ, text, direction, dashedPattern) {
                var link = new JTopo.FoldLink(nodeA, nodeZ, text);
                link.direction = direction || 'horizontal';
                link.arrowsRadius = 10; //箭头大小
                link.lineWidth = 3; // 线宽
                link.bundleOffset = 60; // 折线拐角处的长度
                link.bundleGap = 20; // 线条之间的间隔
                link.textOffsetY = 3; // 文本偏移量（向下3个像素）
                link.strokeColor = JTopo.util.randomColor(); // 线条颜色随机
                link.dashedPattern = dashedPattern;
                scene.add(link);
                return link;
            }

            setInterval(function () {
                if (n1.text == '自定义1') {
                    n1.borderColor = '255,255,255'; //边框颜色  
                } else {
                    n1.borderColor = '0,0,255'; //蓝色  
                }
            }, 600);


        });

        //setInterval(function () {
        //    if (n2.alarm == 'Warrning') {
        //        n2.alarm = null;
        //    } else {
        //        n2.alarm = 'Warrning'
        //    }
        //}, 1000);



        function dosubmit() {
            //var test = findstage.find('node[text="n1"]');
            //alter(test);
            //var n1 = spider(findstage, "n1");
            //alert(n1);
            //var n2 = spider(findstage, "n2");
            //var Link = addLink(n1, n2);
            //alert("1");
        }
        
      
    </script>
</head>

<body>
    <form id="form1" runat="server">
 <input  type="button" id="test" name="test" value="测试" onclick="dosubmit()"/>
   <div id="content">					<canvas width="850" height="550" id="canvas"></canvas>
		 
    </div>
    </form>
</body>
</html>
