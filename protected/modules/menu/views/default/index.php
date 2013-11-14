<?php
/**
 * @var $this Controller
 * @var $dataProvider CDataProvider
 */
$this->breadcrumbs = array(
    Yii::t('menu', 'menu')        => array('default/admin'),
    Yii::t('menu', 'management'),
);

$this->widget(
    'bootstrap.widgets.TbListView',
    array(
        'dataProvider'    => $dataProvider,
        'itemView'        => '_view',
    )
);
