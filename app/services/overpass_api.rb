class OverpassAPI
  include HTTParty
  default_timeout 360
  base_uri 'https://overpass-api.de'

  # API call that returns XBT, lightning, XMR and XG1 results.
  # XBT and lightning are scoped to West Europe only for now.
  def fetch_merchants
    self.class.get('/api/interpreter', query: {
      data: <<-XML
      <osm-script output="json" timeout="360">
        <union into="area">
          <id-query type="area" ref="3602202162" /> <!-- France -->
          <id-query type="area" ref="3601311341" /> <!-- Spain -->
          <id-query type="area" ref="3600051701" /> <!-- Swiss -->
          <id-query type="area" ref="3600295480" /> <!-- Portugal -->
          <id-query type="area" ref="3600365331" /> <!-- Italy -->
          <id-query type="area" ref="3600051477" /> <!-- Germany -->
          <id-query type="area" ref="3600052411" /> <!-- Belgium -->
          <id-query type="area" ref="3606038068" /> <!-- Great Britain -->
          <id-query type="area" ref="3600062273" /> <!-- Irland -->
          <id-query type="area" ref="3600050046" /> <!-- Denmark -->
          <id-query type="area" ref="3601059668" /> <!-- Norge -->
          <id-query type="area" ref="3600054224" /> <!-- Finland -->
          <id-query type="area" ref="3600052822" /> <!-- Sweden -->
          <id-query type="area" ref="3600016239" /> <!-- Austria -->
          <id-query type="area" ref="3600049715" /> <!-- Poland -->
          <id-query type="area" ref="3600214885" /> <!-- Croatia -->
          <id-query type="area" ref="3600192307" /> <!-- Greece -->
          <id-query type="area" ref="3600021335" /> <!-- Hungary -->
          <id-query type="area" ref="3600090689" /> <!-- Romania -->
          <id-query type="area" ref="3600060199" /> <!-- Ukraine -->
          <id-query type="area" ref="3600058974" /> <!-- Moldova -->
          <id-query type="area" ref="3600299133" /> <!-- Island -->
          <id-query type="area" ref="3602171347" /> <!-- Luxembourg -->
          <id-query type="area" ref="3600009407" /> <!-- Andorra -->
          <id-query type="area" ref="3601124039" /> <!-- Monaco -->
          <id-query type="area" ref="3603263726" /> <!-- Cyprus -->
          <id-query type="area" ref="3600365307" /> <!-- Malta -->
          <id-query type="area" ref="3601428125" /> <!-- Canada -->
          <id-query type="area" ref="3600148838" /> <!-- United States -->
          <id-query type="area" ref="3600114686" /> <!-- Mexico -->
          <id-query type="area" ref="3600307833" /> <!-- Cuba -->
          <id-query type="area" ref="3600080500" /> <!-- Australia -->
          <id-query type="area" ref="3600556706" /> <!-- New Zealand -->
          <id-query type="area" ref="3600059470" /> <!-- Brazil -->
          <id-query type="area" ref="3600286393" /> <!-- Argentina -->
          <id-query type="area" ref="3600167454" /> <!-- Chile -->
          <id-query type="area" ref="3600288247" /> <!-- Peru -->
          <id-query type="area" ref="3600287077" /> <!-- Paraguay -->
          <id-query type="area" ref="3600287072" /> <!-- Uruguay -->
          <id-query type="area" ref="3600252645" /> <!-- Bolivia -->
          <id-query type="area" ref="3600192798" /> <!-- Kenya -->
          <id-query type="area" ref="3600195271" /> <!-- Zambia -->
          <id-query type="area" ref="3600087565" /> <!-- South Africa -->
        </union>

        <union>
          <query type="node">
            <has-kv k="currency:XBT" v="yes"/>
            <area-query from="area"/>
          </query>

          <query type="node">
            <has-kv k="payment:lightning" v="yes"/>
            <area-query from="area"/>
          </query>

          <query type="node">
            <has-kv k="currency:XMR" v="yes"/>
          </query>

          <query type="node">
            <has-kv k="currency:XG1" v="yes"/>
          </query>

          <query type="node">
            <has-kv k="currency:June" v="yes"/>
          </query>
        </union>

        <print mode="body"/>
        <recurse type="down"/>
        <print mode="skeleton" order="quadtile"/>
      </osm-script>
      XML
    })
  end
end
