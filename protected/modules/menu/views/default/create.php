<?php
/**
 * @var $this Controller
 * @var $model Menu
 * @var $root bool
 */
$this->breadcrumbs = array(
	Yii::t('menu', 'menu') => array('default/admin'),
	Yii::t('menu', 'addition'),
);

echo $this->renderPartial('_form', array('model' => $model, 'root' => $root));
