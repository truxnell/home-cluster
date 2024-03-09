<?php
include_once '/var/www/html/system/autoload.php';
\Aurora\System\Api::Init(true);

$oSettings = \Aurora\System\Api::GetSettings();
if ($oSettings)
{
    $oSettings->SetConf('DBHost', 'helios.natallan.com:3306');
    $oSettings->SetConf('DBName', 'afterlogic');
    $oSettings->SetConf('DBLogin', 'afterlogic');
    $oSettings->SetConf('DBPassword', 'moartest');
    $oSettings->Save();

    \Aurora\System\Api::GetModuleManager()->SyncModulesConfigs();
}
