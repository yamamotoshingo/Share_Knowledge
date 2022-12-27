$(function() {
  $(".nav-button").on("click", function() {
    if($(this).hasClass("open")) {
      $(".hamburger").addClass("active");
      $(".cross, .menu").removeClass("active");
      $(".nav-button").removeClass("open");
    } else {
      $(".hamburger").removeClass("active");
      $(".cross, .menu").addClass("active");
      $(".nav-button").addClass("open");
    }
  });
});

$(function () {
	let file;
  $('#image').on("change", function () {
    file = this.files[0];
    const fileName = document.getElementById("file-name");
    if (file != null) {
      if (fileName.textContent = "") {
        fileName.insertAdjacentHTML('afterbegin', file.name);
      } else {
        fileName.innerHTML = file.name;
      }
    }
  });
});

$(function() {
  const stars = document.querySelectorAll(".ratings span");
  const ratingValue = document.getElementById("rating-value");
  const ratingValueDisplay = document.getElementById("rating-value-display");
  let index;

  for(let i=0; i<stars.length; i++){
	// 星にカーソルが乗ったときに実行する関数を定義
	  stars[i].addEventListener("mouseover",function(){
		for(let j=0; j<stars.length; j++){
			// まず全て星をくり抜く
			if ( j%2 !== 0) {
			  stars[j].classList.remove("fa-solid");
			  stars[j].classList.add("fa-regular");
			} else {
			  stars[j].style.opacity= "0.0";
		  }
	  }
		// そのあと星の数だけ以下の関数が繰り返される。
		for(let j=0; j<=i; j++){
			if ( j%2 !== 0) {
			  stars[j].classList.remove("fa-regular");
			  // カーソルが乗った星まで星を塗りつぶす
			  stars[j].classList.add("fa-solid");
			} else {
			  stars[j].style.opacity= "1.0";
			}
		}
	  })
	  // クリックされた星の番号+1をratingValueに代入
	  stars[i].addEventListener("click",function(){
		  ratingValue.value = i*0.5+0.5;
		  ratingValueDisplay.textContent = ratingValue.value;
		  // indexにクリックされた星の番号を代入
		  index = i;
	  })
	  // 星からカーソルが離れたときに実行される関数
	  stars[i].addEventListener("mouseout",function(){
		  for(let j=0; j<stars.length; j++){
			  // まず全ての星をくり抜く
			  if ( j%2 !== 0) {
			  stars[j].classList.remove("fa-solid");
			  stars[j].classList.add("fa-regular");
			  } else {
			    stars[j].style.opacity = "0.0";

			  }
		  }
		  for(let j=0; j<=index; j++){
		  	// クリックされている星まで塗りつぶす
			  if ( j%2 !== 0) {
			    stars[j].classList.remove("fa-regular");
			    stars[j].classList.add("fa-solid");
			  } else {
				  stars[j].style.opacity = "1.0";

		    }
		  }
	  })
  }
});

$(function() {
	$('#new-title1').on('keyup change', function(){
		$('#new-title2').val($('#new-title1').val());
	})
	$('#new-content1').on('keyup change', function(){
		$('#new-content2').val($('#new-content1').val());
	})
	let elements = document.querySelectorAll('.new-classification1');
	let label_elements = document.getElementsByName('new-classification1-label');
	let len = elements.length;
	for (let i=0; i<len; i++){
		label_elements[i].addEventListener('click', function(){
			$('#new-classification2').val(elements.item(i).value);
		});
	}
});

$(function() {
  $('.checkbox').on('change', function(){
    const checkboxes2 = $(".checkbox");
    const valueArray = [];

    checkboxes2.each(function() {
    if ($(this).prop("checked")) {
      valueArray.push($(this).val());
    }
    });
    $(".withdrawal").val(valueArray);
    $(".lift").val(valueArray);
    })
});
