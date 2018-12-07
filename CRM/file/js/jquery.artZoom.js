(function (document, $, log) {
$.fn.artZoom = function (config) {
	config = $.extend({}, $.fn.artZoom.defaults, config);
    $this = this;
    var curImg=$(this)[0];
	var tmpl= [
		'<div class="ui-artZoom-toolbar" >',
			'<span class="ui-artZoom-buttons" >',
				'<a href="#" data-go="left" ><span></span>',
					config.left,
				'</a>',
				'<a href="#" data-go="right" ><span></span>',
					config.right,
				'</a>',
				'<a href="#" data-go="max" ><span></span>',
				config.zoomMax,
				'</a>',
				'<a href="#" data-go="min" ><span></span>',
				config.zoomMin,
				'</a>',
				'<a href="#" data-go="source" ><span></span>',
					config.source,
				'</a>',

			'</span>',
		'</div>'
	].join('');

    var wrap = document.createElement('div');
    var $artZoom = $(wrap);
    wrap.className = 'ui-artZoom ui-artZoom-noLoad';
    wrap.innerHTML = tmpl;
    $this.before($artZoom);

    var degree=0;

    var buttonClick=function (event) {
        var target = this;
        var go = target.getAttribute('data-go');

        var curWidth=$(curImg).width();
        var curHeight=$(curImg).height();
        switch (go) {
            case 'left':
                degree -= 90;
                degree = degree === -90 ? 270 : degree;
                break;
            case 'right':
                degree += 90;
                degree = degree === 360 ? 0 : degree;
                break;
            case 'max':
                $(curImg).width(curWidth+10);
                $(curImg).height(curHeight+10);
                if(getExplorer()==='IE8' ||getExplorer()==='IE7'){
                    $('#imgCanvas').width(curWidth+10);
                    $('#imgCanvas').height(curHeight+10);
                    $('#imgCanvas img').width(curWidth+10);
                    $('#imgCanvas img').height(curHeight+10);
                }else{//其他
					$('#imgCanvas').width(curWidth+10);
                    $('#imgCanvas').height(curHeight+10);
				}

                break;
            case 'min':
                $(curImg).width(curWidth-10);
                $(curImg).height(curHeight-10);
                if(getExplorer()==='IE8' ||getExplorer()==='IE7'){
                    $('#imgCanvas').width(curWidth-10);
                    $('#imgCanvas').height(curHeight-10);
                    $('#imgCanvas img').width(curWidth-10);
                    $('#imgCanvas img').height(curHeight-10);
                }else{//其他
                    $('#imgCanvas').width(curWidth-10);
                    $('#imgCanvas').height(curHeight-10);
                }
                break;
            case 'source':
            	var src=$(curImg).attr('src');
                window.open(src);
                break;
        };

        if(go==='left' || go==='right') {
            var maxWidth=$(curImg).width()
                ,maxHeight=$(curImg).height();
            imgRotate(curImg, degree, maxWidth, maxHeight);
        }
        //$this.data('artZoom-degree', degree);
    };

    //工具条按钮事件
    $artZoom.find('[data-go]').on('click', buttonClick);

	return this;
};
$.fn.artZoom.defaults = {
	path: './images',
	left: '\u5de6\u65cb\u8f6c',
	right: '\u53f3\u65cb\u8f6c',
	source: '\u770b\u539f\u56fe',
	hide: '\xd7',
	blur: true,
	preload: true,
	maxWidth: null,
	maxHeight: null,
	borderWidth: 18
};

var getExplorer=function () {
    var explorer = window.navigator.userAgent ;
    //ie
    if (explorer.indexOf("MSIE 7.0") > 0) {
        return 'IE7';
    }else if(explorer.indexOf("MSIE 8.0") >0){
        return 'IE8';
    }
    else if(explorer.indexOf("MSIE 9.0") >0){
        return 'IE9';
    }
    //firefox
    else if (explorer.indexOf("Firefox") >= 0) {
        return 'FIREFOX';
    }
    //Chrome
    else if(explorer.indexOf("Chrome") >= 0){
        return 'CHROME';
    }
    //Opera
    else if(explorer.indexOf("Opera") >= 0){
        return 'OPERA';
    }
    //Safari
    else if(explorer.indexOf("Safari") >= 0){
        return 'SAFARI';
    }

    else{
        return 'IE';
    }
};

/**
 * 图片旋转
 * @version	2011.05.27
 * @author	TangBin
 * @param	{HTMLElement}	图片元素
 * @param	{Number}		旋转角度 (可用值: 0, 90, 180, 270)
 * @param	{Number}		最大宽度限制
 * @param	{Number}		最大高度限制
 */
var imgRotate = $.imgRotate = function () {
	var eCanvas = '{$canvas}',
		isCanvas = !!document.createElement('canvas').getContext;
		
	return function (elem, degree, maxWidth, maxHeight) {
		var x, y, getContext,
			resize = 1,
			width = elem.naturalWidth,
			height = elem.naturalHeight,
			canvas = elem[eCanvas];
		
		// 初次运行
		if (!elem[eCanvas]) {
			
			// 获取图像未应用样式的真实大小 (IE和Opera早期版本)
			if (!('naturalWidth' in elem)) {
				var run = elem.runtimeStyle, w = run.width, h = run.height;
				run.width  = run.height = 'auto';
				elem.naturalWidth = width = elem.width;
				elem.naturalHeight = height = elem.height;
				run.width  = w;
				run.height = h;
			};
		
			elem[eCanvas] = canvas = document.createElement(isCanvas ? 'canvas' : 'span');
			elem.parentNode.insertBefore(canvas, elem.nextSibling);

			elem.style.display = 'none';
			canvas.className = elem.className;
			canvas.title = elem.title;
			canvas.id='imgCanvas';
			if (!isCanvas) {
				canvas.img = document.createElement('img');
				canvas.img.src = elem.src;
				canvas.appendChild(canvas.img);
				canvas.style.cssText = 'display:inline-block;*zoom:1;*display:inline;' +
					// css reset
					'padding:0;margin:0;border:none 0;position:static;float:none;overflow:hidden;width:auto;height:auto';
			};
		};
		
		var size = function (isSwap) {
			if (isSwap) width = [height, height = width][0];
			if (width > maxWidth) {
				resize = maxWidth / width;
				height =  resize * height;
				width = maxWidth;
			};
			if (height > maxHeight) {
				resize = resize * maxHeight / height;
				width = maxHeight / height * width;
				height = maxHeight;
			};
			if (isCanvas) (isSwap ? height : width) / elem.naturalWidth;


		};
		
		switch (degree) {
			case 0:
				x = 0;
				y = 0;
				size();
				break;
			case 90:
				x = 0;
				y = -elem.naturalHeight;
				size(true);
				break;
			case 180:
				x = -elem.naturalWidth;
				y = -elem.naturalHeight
				size();
				break;
			case 270:
				x = -elem.naturalWidth;
				y = 0;
				size(true);
				break;
		};
		
		if (isCanvas) {
			canvas.setAttribute('width', width);
			canvas.setAttribute('height', height);
			getContext = canvas.getContext('2d');
			getContext.rotate(degree * Math.PI / 180);
			getContext.scale(resize, resize);
			getContext.drawImage(elem, x, y);	
		} else {
			canvas.style.width = width + 'px';
			canvas.style.height = height + 'px';// 解决IE8使用滤镜后高度不能自适应
			canvas.img.style.filter = 'progid:DXImageTransform.Microsoft.BasicImage(rotation=' + degree / 90 + ')';
			canvas.img.width = elem.width * resize;
			canvas.img.height = elem.height * resize;
		};
	};
}();


}(document, jQuery, function (msg) {}));
