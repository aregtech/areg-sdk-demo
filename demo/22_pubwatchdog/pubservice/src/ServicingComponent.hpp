#pragma once

/************************************************************************
 * \file        locservice/src/ServicingComponent.hpp
 * \ingroup     AREG SDK, Automated Real-time Event Grid Software Development Kit examples
 * \author      Artak Avetyan
 * \brief       Collection of AREG SDK examples.
 *              This file contains simple implementation of servicing component
 *              to output message and shutdown.
 ************************************************************************/
/************************************************************************
 * Include files.
 ************************************************************************/

#include "areg/base/GEGlobal.h"
#include "areg/component/Component.hpp"
#include "demo/22_pubwatchdog/services/HelloWatchdogStub.hpp"

//////////////////////////////////////////////////////////////////////////
// ServicingComponent class declaration
//////////////////////////////////////////////////////////////////////////
/**
 * \brief   A demo of simple servicing component, which receives request to
            sleep. If sleeping time is bigger than the watchdog timeout, the
            system terminates the thread and restarts again.
 **/
class ServicingComponent    : public    Component
                            , protected HelloWatchdogStub
{
//////////////////////////////////////////////////////////////////////////
// Constructor / destructor
//////////////////////////////////////////////////////////////////////////
public:
    /**
     * \brief   Instantiates the component object.
     * \param   entry   The entry of registry, which describes the component.
     * \param   owner   The component owning thread.
     **/
    ServicingComponent(const NERegistry::ComponentEntry & entry, ComponentThread & owner);

//////////////////////////////////////////////////////////////////////////
// HelloWorld Interface Requests
//////////////////////////////////////////////////////////////////////////
protected:

    /**
     * \brief   Request call.
     *          The response triggered when the thread resumed from suspended mode.
     * \param   timeoutSleep    The timeout in milliseconds to suspend the thread.
     * \see     responseStartSleep
     **/
    virtual void requestStartSleep( unsigned int timeoutSleep ) override;

    /**
     * \brief   Request call.
     *          Called to stop the service.
     * \note    Has no response
     **/
    virtual void requestStopService( void ) override;

    /**
     * \brief   Request call.
     *          Called to shutdown service and exit application.
     * \note    Has no response
     **/
    virtual void requestShutdownService( void ) override;

/************************************************************************/
// StubBase overrides. Triggered by Component on startup.
/************************************************************************/

    /**
     * \brief   This function is triggered by Component when starts up.
     *          Overwrite this method and set appropriate request and
     *          attribute update notification event listeners here
     * \param   holder  The holder component of service interface of Stub,
     *                  which started up.
     **/
    virtual void startupServiceInterface( Component & holder ) override;

//////////////////////////////////////////////////////////////////////////
// Forbidden calls
//////////////////////////////////////////////////////////////////////////
private:
    ServicingComponent( void ) = delete;
    DECLARE_NOCOPY_NOMOVE( ServicingComponent );
};
