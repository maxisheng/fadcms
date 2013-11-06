<?php

class ModelGenerator extends CCodeGenerator
{
	public $codeModel='admin.gii.model.ModelCode';

    /**
     * Provides autoComplete table names
     * @param string $db the database connection component id
     * @throws CHttpException
     * @return string the json array of tableNames that contains the entered term $q
     */
	public function actionGetTableNames($db)
	{
		if(Yii::app()->getRequest()->getIsAjaxRequest())
		{
			$all = array();
			if(!empty($db) && Yii::app()->hasComponent($db)!==false && (Yii::app()->getComponent($db) instanceof CDbConnection))
				$all=array_keys(Yii::app()->{$db}->schema->getTables());

			echo json_encode($all);
		}
		else
			throw new CHttpException(404,'The requested page does not exist.');
	}
}