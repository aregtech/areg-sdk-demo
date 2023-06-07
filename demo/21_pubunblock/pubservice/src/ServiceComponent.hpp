#pragma once

/************************************************************************
 * \file        pubservice/src/ServiceComponent.hpp
 * \ingroup     AREG Asynchronous Event-Driven Communication Framework examples
 * \author      Artak Avetyan
 * \brief       Collection of AREG SDK examples.
 *              This file is demonstration of manual unlbocking of the request.
 ************************************************************************/
 /************************************************************************
  * Include files.
  ************************************************************************/
#include "areg/base/GEGlobal.h"
#include "areg/component/Component.hpp"
#include "areg/component/IETimerConsumer.hpp"
#include "generated/src/HelloUnblockStub.hpp"

#include "areg/base/TEStack.hpp"
#include "areg/component/Timer.hpp"

/**
 * \brief   This service receives the request and immediately manually
 *          unblocks it, so that the client(s) can send same request again.
 *          When 500 ms (NEHelloUnblock::ServiceTimeout) expires, it
 *          manually prepares the response and replies to the client forwarding
 *          client ID and generated by client sequence ID, so that the
 *          client can check that no response is missed or mixed.
 *          Start multiple instance of client to make sure that all responses
 *          are properly replied.
 **/
class ServiceComponent  : public  Component
                        , private HelloUnblockStub
                        , private IETimerConsumer
{
//////////////////////////////////////////////////////////////////////////
// Internal structure
//////////////////////////////////////////////////////////////////////////
    //!< A structure to store data to send to the client(s)
    struct SessionEtnry
    {
        uint32_t    clientId{ NEHelloUnblock::InvalidId};   //!< Client ID
        uint32_t    seqNr   { NEHelloUnblock::InvalidId };  //!< The sequence ID generate by client
        uint32_t    id      { NEHelloUnblock::InvalidId };  //!< Request session ID used to prepare response.
    };

    //!< The stack of session entries
    using SessionList = TENolockStack<SessionEtnry>;

//////////////////////////////////////////////////////////////////////////
// Static methods
//////////////////////////////////////////////////////////////////////////
public:
    /**
     * \brief   Called by system to instantiate the component.
     * \param   entry   The entry of registry, which describes the component.
     * \param   owner   The component owning thread.
     * \return  Returns instantiated component to run in the system
     **/
    static Component * CreateComponent( const NERegistry::ComponentEntry & entry, ComponentThread & owner );

    /**
     * \brief   Called by system to delete component and free resources.
     * \param   compObject  The instance of component previously created by CreateComponent method.
     * \param   entry   The entry of registry, which describes the component.
     **/
    static void DeleteComponent( Component & compObject, const NERegistry::ComponentEntry & entry );

//////////////////////////////////////////////////////////////////////////
// Constructor / destructor
//////////////////////////////////////////////////////////////////////////
protected:

    /**
     * \brief   Instantiates the component object.
     * \param   entry   The entry of registry, which describes the component.
     * \param   owner   The component owning thread.
     **/
    ServiceComponent( const NERegistry::ComponentEntry & entry, ComponentThread & owner );

    /**
     * \brief   Destructor.
     **/
    virtual ~ServiceComponent( void ) = default;

protected:

    /**
     * \brief   This function is triggered by Component when starts up.
     * \param   holder  The holder component of service interface of Stub,
     *                  which started up.
     **/
    virtual void startupServiceInterface( Component & holder ) override;

    /**
     * \brief   Request call.
     *          Request to assign an ID to the client used to to call unblock request.
     * \see     responseIdentifier
     **/
    virtual void requestIdentifier( void ) override;

    /**
     * \brief   Request call.
     *          Request to print hello world
     * \param   clientId    The given ID of the client. Should be 0 if unknown
     * \param   seqNr       The sequence number generated by the client. On each request the client increase the sequence number
     *          and stops sending request when reach the maximum.
     * \see     responseHelloUnblock
     **/
    virtual void requestHelloUblock( unsigned int clientId, unsigned int seqNr ) override;

    /**
     * \brief   Triggered when Timer is expired. 
     * \param   timer   The timer object that is expired.
     **/
    virtual void processTimer( Timer & timer ) override;

//////////////////////////////////////////////////////////////////////////
// Hidden methods
//////////////////////////////////////////////////////////////////////////
private:
    inline ServiceComponent & self (void)
    {
        return (*this);
    }

    inline void printRequest( uint32_t clientId, uint32_t seqNr, uint32_t sessionId );

    inline void printResponse( uint32_t clientId, uint32_t seqNr, uint32_t sessionId );

//////////////////////////////////////////////////////////////////////////
// Member variables
//////////////////////////////////////////////////////////////////////////
private:
    SessionList     mSessionList;   //!< The list of sessions to track.
    Timer           mTimer;         //!< Timer to unlock request.

//////////////////////////////////////////////////////////////////////////
// Forbidden calls
//////////////////////////////////////////////////////////////////////////
private:
    ServiceComponent( void ) = delete;
    DECLARE_NOCOPY_NOMOVE( ServiceComponent );
};