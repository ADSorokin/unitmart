<?php
	$config = $sconfig;
	$theme  = $themename;
	$span = 12/$cols;
	$id = rand(1,9)+substr(md5($heading_title),0,3);
	$themeConfig = (array)$config->get('themecontrol');
	$listingConfig = array(
		'category_pzoom'    => 1,
		'quickview'         => 0,
		'product_layout'	=> 'default',
		'enable_paneltool'	=> 0
	);
	$listingConfig = array_merge($listingConfig, $themeConfig );
	$quickview     = $listingConfig['quickview'];
	$categoryPzoom = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0;


	if( $listingConfig['enable_paneltool'] && isset($_COOKIE[$theme.'_productlayout']) && $_COOKIE[$theme.'_productlayout'] ){
		$listingConfig['product_layout'] = trim($_COOKIE[$theme.'_productlayout']);
	}
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';	
	if( !is_file($productLayout) ){
		$listingConfig['product_layout'] = 'default';
	}
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';

	
	$load = $this->registry->get("load");
	$language = $load->language("module/themecontrol");
	$quick_view = $language['quick_view'];
	$button_cart = $this->language->get('button_cart');
	$config = $this->registry->get('config');
	$columns_count=1;
?>


<div class="listproduct-v3 hidden-xs panel <?php echo $addition_cls; ?>">
	<?php if( $show_title ) { ?>
	<div class="panel-heading"><h4 class="panel-title"><?php echo $heading_title?></h4></div>
	<?php } ?>
   <div class="panel-body padding-0">
	<div class="row">		
		<!-- col2 first product -->
		<div class="col-xs-12 col-sm-5 col-md-6 col-lg-6">
			<?php require( DIR_TEMPLATE.$themename.'/template/common/product/first_product.tpl');?>
		</div>
		<!-- column 1 -->		
		<div class="col-xs-12 col-sm-7 col-md-6 col-lg-6 padding-left-0">	
			<div class="owl-carousel-play" id="carousel<?php echo $id;?>" data-ride="owlcarousel">	
				<?php if( count($list1) > $itemsperpage ) { ?>
					<div class="carousel-controls">
						<a class="carousel-control left" href="#carousel<?php echo $id;?>"   data-slide="prev">
							<i class="zmdi zmdi-chevron-left"></i>
						</a>
						<a class="carousel-control right" href="#carousel<?php echo $id;?>"  data-slide="next">
							<i class="zmdi zmdi-chevron-right"></i>
						</a>
					</div>

				<?php } ?>	
				<div class="owl-carousel product-grid"  data-show="<?php echo ($columns_count); ?>" data-pagination="false" data-navigation="true">
					<?php $pages = array_chunk( $list1, $itemsperpage); ?>
					<?php foreach ($pages as  $k => $tproducts ) {   ?>
					<div class="item <?php if($k==0) {?>active<?php } ?> products-block col-nopadding">
						<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
							<?php if( $i%$cols == 1 || $cols == 1) { ?>
							<div class="row products-row <?php ;if($i == count($tproducts) - $cols +1) { echo "last";} ?>"><?php //start box-product?>
							<?php } ?>
								<div class="col-md-<?php echo $span;?> col-sm-<?php echo $span;?> col-xs-12 <?php if($i%$cols == 0) { echo "last";} ?> product-col border">
									<?php require( $productLayout );  ?>
								</div>

							<?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
							</div><?php //end box-product?>
							<?php } ?>
						<?php } //endforeach; ?>
					</div>
				  <?php } ?>
				</div>
			
			</div>
		</div>

	</div>
	</div>
</div>