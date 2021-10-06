xquery version "3.0";

module namespace dm ="http://clarin.ids-mannheim.de/standards/domain-module";
import module namespace app="http://clarin.ids-mannheim.de/standards/app" at "app.xql";
import module namespace spec="http://clarin.ids-mannheim.de/standards/specification" at "../model/spec.xqm";
import module namespace domain="http://clarin.ids-mannheim.de/standards/domain" at "../model/domain.xqm";

(:  Define domain-related functions
    @author margaretha
:)

(: Retrieve a domain node by its id :)
declare function dm:get-domain($id as xs:string){
    domain:get-domain($id)
};

declare function dm:get-domain-by-name($name as xs:string){
    domain:get-domain-by-name($name)
};


(: Generate the list of domains for the particular group :)
declare function dm:list-domains($group as xs:string){
    for $domain in $domain:domains[@orderBy eq $group]
        let $domain-id := $domain/@id (: this is now always empty :)
        let $domain-name := $domain/name/text()
        let $domain-snippet := $domain/desc
        order by $domain-name
    return
        <div>
            <li>
               <span class="list-text">{$domain-name}</span>
                <img class="copy-icon pointer" src="{app:resource("copy.png","img")}" width="14"  
                onclick="copyTextToClipboard('{$domain-id}','{$domain-name}')"/>
                <span class="hint" id="hint-{$domain-id}">copied</span>
            </li>
               <span id="{$domain-id}" style="display:block">
                    <p>{$domain-snippet}</p>
                </span>
        </div>
};

(: iterate across the groups of domains :)
declare function dm:list-domains-grouped(){
  for $group in distinct-values($domain:domains/@orderBy)
  order by $group
  return 
<div>
<li>
     <h3>{$group}</h3>
     <ul>{dm:list-domains($group)}</ul>
  </li>
</div>
};
