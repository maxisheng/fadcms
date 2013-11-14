<?php
/**
 * @var $this Controller
 * @var $model Menu|NestedSetBehavior
 */
$this->breadcrumbs = array(
    Yii::t('menu', 'menu')        => array('default/admin'),
    Yii::t('menu', 'change ' . $model->title),
);
echo $this->renderPartial('_form', array('model' => $model, 'root' => $model->isRoot()));
