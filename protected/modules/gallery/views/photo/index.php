<?php
/**
 * @var $this Controller
 * @var $dataProvider CDataProvider
 */
$this->breadcrumbs = array(
    Yii::t('GalleryModule.gallery', 'Photos'),
);

$this->widget(
    'bootstrap.widgets.TbListView',
    array(
        'dataProvider' => $dataProvider,
        'itemView'     => '_view',
    )
);
