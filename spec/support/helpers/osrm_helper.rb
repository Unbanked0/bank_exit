module OSRMHelper
  OSRM_BASE_URL = 'router.project-osrm.org/route/v1/driving'.freeze

  def stub_osrm_success(duration: 600, distance: 5000)
    url = /#{OSRM_BASE_URL}/o

    body = {
      'routes' => [
        {
          'distance' => distance,
          'duration' => duration,
          'legs' => [],
          # Routing "Bourg-La-Reine (92)"
          'geometry' => 'civhHmlcMQzAE^CRADCPqBq@UGe@Qu@WOEOGeBi@SGa@MCAGC_@MWIa@MUIc@Mq@Q_Bc@QGKC[GIC[GIAOEBK@KLgARcAx@sDPs@Ns@DSBKPs@Ns@^qBDO@GJ_@DMHm@PcAJg@D]Ls@DQ??'
        }
      ],
      'waypoints' => [{ name: 'Bourg-La-Reine' }],
      'code' => 'Ok'
    }

    stub_request(:get, url).to_return(
      status: 200,
      body: body.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  def stub_osrm_failure(status: 400, message: 'Invalid coordinates')
    url = /#{OSRM_BASE_URL}/o

    body = {
      'code' => 'InvalidQuery',
      'message' => message
    }

    stub_request(:get, url).to_return(
      status: status,
      body: body.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end
