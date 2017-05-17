//
//  ViewController.swift
//  test
//
//  Created by Admin on 27.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO
import JSQMessagesViewController

struct User
{
    let id:String
    let name:String
}


class ViewController: JSQMessagesViewController {

    @IBOutlet weak var text: UITextField!

    var c: Bool =  false

    let me = User(id: "me", name: "I")
    let bob = User(id: "bot", name: "Bot")

    var messages = [JSQMessage]();

    var bot:RecastAIClient?
    var forecast:DarkSkyClient?

    func onSend(_ text:String) {
        bot?.textConverse(text, successHandler: {
            res in
            if ((res.replies?.count)! < 1)
            {
                self.messages.append(JSQMessage(senderId: self.bob.id, displayName: self.bob.name, text: "What?"))
                self.finishReceivingMessage(animated: true)
                //self.messager.text.append("What?\n")
            }
            if(res.entities != nil)
            {
                if res.entities?["location"] != nil
                {
                    let ent: [String: Any] = (res.entities?["location"] as? [[String:Any]]?)!![0]
                    let lat = ent["lat"] as? Double
                    let lng = ent["lng"] as? Double
                    self.forecast?.getForecast(latitude: lat!, longitude: lng!, completion: {
                    forc in
                        self.messages.append(JSQMessage(senderId: self.bob.id, displayName: self.bob.name, text: forc.value.0?.currently?.summary))
                        self.finishReceivingMessage(animated: true)
                    })
                }
                else
                {
                    self.messages.append(JSQMessage(senderId: self.bob.id, displayName: self.bob.name, text: "In what city?"))
                    self.finishReceivingMessage(animated: true)
                }
            }
            //print(res.replies[0])
        }, failureHandle: {
            err in
            self.messages.append(JSQMessage(senderId: self.bob.id, displayName: self.bob.name, text: "What?"))
            self.finishReceivingMessage(animated: true)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = me.id
        self.senderDisplayName = me.name
        messages.append(JSQMessage(senderId: me.id, displayName: me.name, text: "HI"))
        messages.append(JSQMessage(senderId: bob.id, displayName: bob.name, text: "HI"))
        bot = RecastAIClient(token: "", language:"en")
        forecast = DarkSkyClient(apiKey:"")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        if (messages[indexPath.row].senderId == "me")
        {
            return JSQMessagesBubbleImageFactory()?.incomingMessagesBubbleImage(with: .green)
        }
        return  JSQMessagesBubbleImageFactory()?.incomingMessagesBubbleImage(with: .blue)
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        return NSAttributedString(string: messages[indexPath.row].senderDisplayName)

    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }

    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        if (text != nil)
        {
            if (text != "")
            {
                onSend(text)
            }
        }
        messages.append(message!)
        finishSendingMessage()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
