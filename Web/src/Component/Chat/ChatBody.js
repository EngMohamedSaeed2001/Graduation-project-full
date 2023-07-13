import React from 'react'
import {useNavigate} from "react-router-dom"

import Load from "../../Helper/Load";
import ScrollToBottom from "react-scroll-to-bottom"
import styled from "styled-components";

const ChatBody = ({load,show,data}) => {


    return (

        <Container>
      {/*<div className="chat-header">*/}
      {/*  <div className="user-details">*/}
      {/*    <div className="avatar">*/}
      {/*      <img src={currentChat.avatarImage} alt="current Chat avatar" />*/}
      {/*    </div>*/}
      {/*    <div className="username">*/}
      {/*      <h3>{currentChat.username}</h3>*/}
      {/*    </div>*/}
      {/*  </div>*/}
      {/*  <Logout />*/}
      {/*</div>*/}
      {!load ? (
        <div className="loading-messages">
          <img src={load} alt="loader" className="loader" />
        </div>
      ) : (
          <div className='chat-messages'>
              <ScrollToBottom mode={"bottom"} >
             {data.map((message) => {
            return (
              // <div ref={scrollRef} key={uuidv4()}>
                <div className={`message ${message.senderEmail === localStorage.getItem("user_email") ? "sended" : "recieved"}`}>

                  {message.message && (
                    <div className="content ">
                      <p>{message.message}</p>
                        <span style={{fontWeight:"bold",fontSize:"0.8rem"}}>
                            <p style={{float:"left",marginRight:"1rem"}}>{message.dates.slice(0,11)}</p>

                            <p style={{float:"right",marginLeft:"1rem"}}>{message.dates.slice(11,-3)}{parseInt(message.dates.slice(11,13))>=12?"  pm":"  am"}</p>

                        </span>
                    </div>
                  )}


                  {/*{message.image && (*/}
                  {/*  <div className="content-image">*/}
                  {/*    <img src={message.image} alt="sended" />*/}
                  {/*  </div>*/}
                  {/*)}*/}
                </div>

            );
          })}
           </ScrollToBottom>
          </div>

      )}
      {/*<ChatInput handleSendMessage={handleSendMessage} />*/}
    </Container>
  );
};

const Container = styled.div`
  display: grid;
  grid-template-rows: 10% 80% 10%;
  /* gap: 0.1rem; */
  overflow: auto;
  height:100%;
  
  .chat-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 2rem;
    border-bottom: 1px solid #ffffff15;
    -webkit-box-shadow: 0px 17px 20px -26px rgba(66, 68, 90, 1);
    -moz-box-shadow: 0px 17px 20px -26px rgba(66, 68, 90, 1);
    box-shadow: 0px 17px 20px -26px rgba(66, 68, 90, 1);
    .user-details {
      display: flex;
      align-items: center;
      gap: 1rem;
      .avatar {
        img {
          height: 3.1rem;
        }
      }
      .username {
        h3 {
          color: #e4e6eb;
        }
      }
    }
    @media screen and (min-width: 720px) {
      .avatar {
        img {
          height: 3rem;
        }
      }
    }
  }

  .loading-messages {
    text-align: center;
    margin-top: 35vh;
    img {
      width: 120px;
      height: 120px;
    }
  }

  .chat-messages {
    
    padding: 1rem 2rem;
    display: flex;
    flex-direction: column;
    gap: 1rem;
    overflow: auto;
    height:1000px;
    
    &::-webkit-scrollbar {
      width: 0.2rem;
      &-thumb {
        background-color: #ffffff39;
        width: 0.1rem;
        border-radius: 1rem;
      }
    }
    .message {
      display: flex;
      align-items: center;
      margin-bottom:30px;
      .content {
        max-width: 80%;
        overflow-wrap: break-word;
        padding: 0.5rem 1rem;
        text-align:right;
        font-size: 0.9rem;
        font-weight:800px;
        border-radius: 15px;
        color: #d1d1d1;
        @media screen and (min-width: 720px) {
          max-width: 50%;
          font-size: 1.1rem;
        }
      }
      .content-image {
        max-width: 70%;
        /* justify-self: flex-end; */
        img {
          max-width: 300px;
        }
      }
    }
    .sended {
      justify-content: flex-end;
      margin-right:5%;
      .content {
       background-color: #529af5;
      }
    }
    .recieved {
      justify-content: flex-start;
      margin-left:10%;
      .content {
        
         background-color: #3e4b59;
      }
    }
  }
  @media screen and (max-width: 900px) and (orientation: landscape) {
    grid-template-rows: 15% 70% 15%;

    .chat-header {
      .user-details {
        .avatar {
          img {
            height: 2.6rem;
          }
        }
      }
    }
  }
`;

export default ChatBody