/**
 * \file    common/src/ServiceComponent.hpp
 * \brief   Declaration of the service component.
 **/
#pragma once

#include "areg/base/GEGlobal.h"
#include "areg/component/Component.hpp"
#include "demo/03_helloservice/services/HelloServiceStub.hpp"

//////////////////////////////////////////////////////////////////////////
// ServiceComponent declaration
//////////////////////////////////////////////////////////////////////////
class ServiceComponent  : public    Component
                        , protected HelloServiceStub
{
public:
    ServiceComponent(const NERegistry::ComponentEntry & entry, ComponentThread & owner);

protected:
//////////////////////////////////////////////////////////////////////////
// HelloService Interface Requests
//////////////////////////////////////////////////////////////////////////
    /**
     * \brief   The request to output a greeting.
     * \param   client  The name of the client to output the greeting.
     **/
    virtual void requestHelloService( const String & client ) override;

//////////////////////////////////////////////////////////////////////////
// Forbidden calls
//////////////////////////////////////////////////////////////////////////
private:
    ServiceComponent( void ) = delete;
    DECLARE_NOCOPY_NOMOVE( ServiceComponent );
};
