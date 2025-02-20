xquery version "3.0";

module namespace recommendation="http://clarin.ids-mannheim.de/standards/recommendation-model";

(: Define the methods for accessing recommendations
   @author margaretha
:)

declare variable $recommendation:centres := collection('/db/apps/clarin/data/recommendations')/result;


declare function recommendation:get-recommendations-for-format($format-id){
    $recommendation:centres[formats/format/name/@id=$format-id]
};