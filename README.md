# **Sequía Agricola**
<p> Las sequías tienen efectos considerables en las zonas agrícolas y agropastoriles debido a su gran dependencia de las precipitaciones. El monitoreo de la sequía agrícola es muy importante para mantener la seguridad alimentaria en el mundo.</p><br>

<p> La teledetección satelital se usa ampliamente para monitorear la salud de la vegetación y se ha convertido en un poderoso enfoque de detección de sequías, debido a su uso a nivel mundial. </p><br>

<p>Los índices se han desarrollado utilizando datos de teledetección como el Índice de Vegetación de Diferencia Normalizada (NDVI), la Temperatura de la Superficie Terrestre (LST), el Índice de Condición de la Vegetación (VCI) y el Índice de Salud de la Vegetación (VHI). </p><br>

<p> $VCI_{j} = {\frac{ NDVI_{j} - NDVI_{min} }{ NDVI_{max} - NDVI_{min} }} * 100$</p><br>

<p> $TCI_{j} = {\frac{ TCI_{j} - TCI_{min} }{ TCI_{max} - TCI_{min} }} * 100$</p><br>

<p> $VHI = \alpha * VCI + (1 - \alpha) * TCI $</p><br>

<p>Donde   $NDVI_{max}$, $TCI_{max}$,  $NDVI_{min} y $TCI_{min}$, corresponden al NDVI y TCI máximos y mínimos de toda la serie de tiempo.  $VCI_{j}$, $TCI_{j}$ y  $VHI$, corresponden a la condición de la vegetación, condición de la temperatura y salud de la vegetación mensual. El valor $\alpha$ es el peso para medir la contribución del VCI y TCI para evaluar el estado de sequía. Generalmente, α se establece en 0,5 porque es difícil distinguir la contribución de la temperatura superficial y el NDVI al medir el estrés por sequía. </p><br>

<p> Estos se emplean para iniciar y monitorear la sequía agrícola en relación con el crecimiento de las plantas.</p><br>

<p> La práctica recomendada está preparada para monitorear y realizar alertas tempranas de sequía agrícola y se puede adaptar fácilmente utilizando Google Earth Engine.</p><br>

<p> En este repositorio se muestra el procesamiento de imagenes MODIS para la estimación del LST, VCI y VHI tomando como caso práctico la región de estudio del Patía (Colombia). Los procedimientos tomados para esta caso se basaron en las recomendaciones y procedimientos mencionados por las Naciones Unidas (<a href="https://un-spider.org/advisory-support/recommended-practices/recommended-practice-agriculture-drought-monitoring/in-detail">UN1 </a>, <a href="https://un-spider.org/advisory-support/recommended-practices/recommended-practice-agriculture-drought-monitoring/step-by-step">UN2 </a>)</p><br>



<p> </p><br>