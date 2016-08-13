ALTER TABLE `users` ADD `override_class` TINYINT( 3 ) UNSIGNED DEFAULT '255' NOT NULL AFTER `class`;

DROP TABLE `messages`;
CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `sender` int(10) unsigned NOT NULL default '0',
  `receiver` int(10) unsigned NOT NULL default '0',
  `added` datetime default NULL,
  `subject` varchar(60) NOT NULL default 'No Subject',
  `msg` text,
  `unread` enum('yes','no') NOT NULL default 'yes',
  `poster` bigint(20) unsigned NOT NULL default '0',
  `location` smallint(6) NOT NULL default '1',
  `saved` enum('no','yes') NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `receiver` (`receiver`)
) TYPE=MyISAM ;

-- 
-- Table structure for table `requests`
-- 

CREATE TABLE `requests` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(10) unsigned NOT NULL default '0',
  `request` varchar(225) default NULL,
  `descr` text NOT NULL,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `hits` int(10) unsigned NOT NULL default '0',
  `cat` int(10) unsigned NOT NULL default '0',
  `filled` varchar(75) default NULL,
  `filledby` int(10) unsigned NOT NULL default '0',
  `filldate` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`)
) TYPE=MyISAM ;

-- 
-- Table structure for table `addedrequests`
-- 

CREATE TABLE `addedrequests` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `requestid` int(10) unsigned NOT NULL default '0',
  `userid` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `pollid` (`id`),
  KEY `userid` (`userid`)
) TYPE=MyISAM ;


-- 
-- Table structure for table `notconnectablepmlog`
-- 

CREATE TABLE notconnectablepmlog (
  id int(10) unsigned NOT NULL auto_increment,
  `user` int(10) unsigned NOT NULL default '0',
  `date` datetime default NULL,
  PRIMARY KEY  (id)
) TYPE=MyISAM AUTO_INCREMENT=2 ;


-- 
-- Table structure for table `adminpanel`
-- 

DROP TABLE IF EXISTS `adminpanel`;
CREATE TABLE IF NOT EXISTS `adminpanel` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `url` varchar(50) default NULL,
  `info` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM AUTO_INCREMENT=2012 ;

-- 
-- Dumping data for table `adminpanel`
-- 

INSERT DELAYED IGNORE INTO `adminpanel` (`id`, `name`, `url`, `info`) VALUES (2002, 'News page', 'news.php', 'Add, edit and remove news items from the homepage'),
(2001, 'Manage Category', 'categorie.php', 'Add, edit and delete categories'),
(2003, 'Create Poll', 'makepoll.php', 'Create a new poll'),
(2004, 'Poll Overview', 'polloverview.php', 'See what the users have voted in the polls'),
(2005, 'Mass Email', 'massemail.php', 'Send a mass email to all users'),
(2006, 'Mass PM', 'staffmess.php', 'Send a message to the different user classes'),
(2007, 'Unconfirmed Users', 'uncon.php', 'Manage unconfirmed users'),
(2008, 'Not Connectable', 'findnotconnectable.php', 'PM all users that are not connectable'),
(2009, 'Ban IP', 'bans.php', 'Ban ip or ip range from the site'),
(2010, 'Add User', 'adduser.php', 'Create new user account'),
(2011, 'Delete User', 'delacctadmin.php', 'Delete a user'),
(2012, 'Update Users Invites', 'inviteadd.php', 'Update Users Invite Amounts');

-- --------------------------------------------------------

-- 
-- Table structure for table `modpanel`
-- 

DROP TABLE IF EXISTS `modpanel`;
CREATE TABLE IF NOT EXISTS `modpanel` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `url` varchar(50) default NULL,
  `info` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM AUTO_INCREMENT=1008 ;

-- 
-- Dumping data for table `modpanel`
-- 

INSERT DELAYED IGNORE INTO `modpanel` (`id`, `name`, `url`, `info`) VALUES (1001, 'Site Statistics', 'statistics.php', 'Registration, Rating, Post, PM, Torrents, Ban, Comment'),
(1002, 'Uploading Stats', 'stats.php', 'List upload activity and category activity'),
(1003, 'Newest users', 'controlpanel.php?act=last', '100 newest user accounts'),
(1004, 'Client Lister', 'clientlister.php', 'List all clients the users are using'),
(1005, 'Delete Req', 'delreq.php', 'Delete torrent request(s)'),
(1006, 'Test IP', 'testip.php', 'Test IP (check if banned or not)'),
(1007, 'Manage FAQ', 'faqmanage.php', 'Add, edit and remove items from the FAQ'),
(1008, 'Manage Warnings', 'warned.php', 'Edit warned users'),
(1009, 'Cleanup', 'docleanup.php', 'Perform a cleanup');

-- --------------------------------------------------------

-- 
-- Table structure for table `sysoppanel`
-- 

DROP TABLE IF EXISTS `sysoppanel`;
CREATE TABLE IF NOT EXISTS `sysoppanel` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `url` varchar(50) default NULL,
  `info` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM AUTO_INCREMENT=3003 ;

-- 
-- Dumping data for table `sysoppanel`
-- 

INSERT DELAYED IGNORE INTO `sysoppanel` (`id`, `name`, `url`, `info`) VALUES (3000, 'Apache Style Statistics', 'info.php', 'Apache style Statistics: Ip,Browser,Whence,Page'),
(3001, 'MySQL Query', 'sqlcmdex.php', 'Run SQL query/queries on database .'),
(3002, 'MySQL Overview', 'mysql_overview.php', 'Mysql Table/Overhead Overview, Tells when tables need optimising!'),
(3003, 'Phpinfo Page', 'phpinfo.php', 'Display the php config');

-- --------------------------------------------------------

-- 
-- Table structure for table `faq`
-- 

CREATE TABLE `faq` (
  `id` int(10) NOT NULL auto_increment,
  `type` set('categ','item') NOT NULL default 'item',
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `flag` set('0','1','2','3') NOT NULL default '1',
  `categ` int(10) NOT NULL default '0',
  `order` int(10) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM AUTO_INCREMENT=66 ;

-- 
-- Dumping data for table `faq`
-- 

INSERT INTO `faq` VALUES (1, 'categ', 'Site information', '', '1', 0, 1);
INSERT INTO `faq` VALUES (2, 'categ', 'User information', '', '1', 0, 2);
INSERT INTO `faq` VALUES (3, 'categ', 'Stats', '', '1', 0, 3);
INSERT INTO `faq` VALUES (4, 'categ', 'Uploading', '', '1', 0, 4);
INSERT INTO `faq` VALUES (5, 'categ', 'Downloading', '', '1', 0, 5);
INSERT INTO `faq` VALUES (6, 'categ', 'How can I improve my download speed?', '', '1', 0, 6);
INSERT INTO `faq` VALUES (7, 'categ', 'My ISP uses a transparent proxy. What should I do?', '', '1', 0, 7);
INSERT INTO `faq` VALUES (8, 'categ', 'Why can''t I connect? Is the site blocking me?', '', '1', 0, 8);
INSERT INTO `faq` VALUES (9, 'categ', 'What if I can''t find the answer to my problem here?', '', '1', 0, 9);
INSERT INTO `faq` VALUES (10, 'item', 'What is this bittorrent all about anyway? How do I get the files?', 'Check out <a class="altlink" href="http://www.btfaq.com/">Brian''s BitTorrent FAQ and Guide</a>', '1', 1, 1);
INSERT INTO `faq` VALUES (11, 'item', 'Where does the donated money go?', 'TorrentBits.org is situated on a dedicated server in the Netherlands. For the moment we have monthly running costs of approximately � 213.\r\n', '1', 1, 2);
INSERT INTO `faq` VALUES (12, 'item', 'Where can I get a copy of the source code?', 'Snapshots are available on the <a href="ftp://torrentbits.org/snapshots/" class="altlink">FTP</a>. Please note: We do not give any kind of support on the source code so please don''t bug us about it. If it works, great, if not too bad. Use this software at your own risk!\r\n<br/><br/>\r\n<a href="http://www.geocities.com/themisterofmisters/tbsourcetut-v0.1.txt">Here</a> is a nice tutorial on getting it all to work, written by one of our users. Note: This tutorial is not supported by TB. Please direct all comments on the tutorial to the author, <b>MrMister</b>.', '1', 1, 3);
INSERT INTO `faq` VALUES (13, 'item', 'I registered an account but did not receive the confirmation e-mail!', 'You can use <a class="altlink" href="delacct.php">this form</a> to delete the account so you can re-register.\r\nNote though that if you didn''t receive the email the first time it will probably not\r\nsucceed the second time either so you should really try another email address.', '1', 2, 1);
INSERT INTO `faq` VALUES (14, 'item', 'I''ve lost my user name or password! Can you send it to me?', 'Please use <a class="altlink" href="recover.php">this form</a> to have the login details mailed back to you.', '1', 2, 2);
INSERT INTO `faq` VALUES (15, 'item', 'Can you rename my account?', 'We do not rename accounts. Please create a new one. (Use <a href="delacct.php" class="altlink">this form</a> to\r\ndelete your present account.)', '1', 2, 3);
INSERT INTO `faq` VALUES (16, 'item', 'Can you delete my (confirmed) account?', 'You can do it yourself by using <a href="delacct.php" class="altlink">this form</a>.', '2', 2, 4);
INSERT INTO `faq` VALUES (17, 'item', 'So, what''s MY ratio?', 'Click on your <a class="altlink" href="my.php">profile</a>, then on your user name (at the top).<br/>\r\n<br/>\r\nIt''s important to distinguish between your overall ratio and the individual ratio on each torrent\r\nyou may be seeding or leeching. The overall ratio takes into account the total uploaded and downloaded\r\nfrom your account since you joined the site. The individual ratio takes into account those values for each torrent.<br/>\r\n<br/>\r\nYou may see two symbols instead of a number: &quot;Inf.&quot;, which is just an abbreviation for Infinity, and\r\nmeans that you have downloaded 0 bytes while uploading a non-zero amount (ul/dl becomes infinity); &quot;---&quot;,\r\nwhich should be read as &quot;non-available&quot;, and shows up when you have both downloaded and uploaded 0 bytes\r\n(ul/dl = 0/0 which is an indeterminate amount).', '1', 2, 5);
INSERT INTO `faq` VALUES (18, 'item', 'Why is my IP displayed on my details page?', 'Only you and the site moderators can view your IP address and email. Regular users do not see that information.', '1', 2, 6);
INSERT INTO `faq` VALUES (19, 'item', 'Help! I cannot login!? (a.k.a. Login of Death)', 'This problem sometimes occurs with MSIE. Close all Internet Explorer windows and open Internet Options in the control panel. Click the Delete Cookies button. You should now be able to login.\r\n', '1', 2, 7);
INSERT INTO `faq` VALUES (20, 'item', 'My IP address is dynamic. How do I stay logged in?', 'You do not have to anymore. All you have to do is make sure you are logged in with your actual\r\nIP when starting a torrent session. After that, even if the IP changes mid-session,\r\nthe seeding or leeching will continue and the statistics will update without any problem.', '2', 2, 8);
INSERT INTO `faq` VALUES (21, 'item', 'Why is my port number reported as "---"? (And why should I care?)', 'The tracker has determined that you are firewalled or NATed and cannot accept incoming connections.\r\n<br/>\r\n<br/>\r\nThis means that other peers in the swarm will be unable to connect to you, only you to them. Even worse,\r\nif two peers are both in this state they will not be able to connect at all. This has obviously a\r\ndetrimental effect on the overall speed.\r\n<br/>\r\n<br/>\r\nThe way to solve the problem involves opening the ports used for incoming connections\r\n(the same range you defined in your client) on the firewall and/or configuring your\r\nNAT server to use a basic form of NAT\r\nfor that range instead of NAPT (the actual process differs widely between different router models.\r\nCheck your router documentation and/or support forum. You will also find lots of information on the\r\nsubject at <a class="altlink" href="http://portforward.com/">PortForward</a>).', '1', 2, 9);
INSERT INTO `faq` VALUES (22, 'item', 'What are the different user classes?', '<table cellspacing="3" cellpadding="0">\r\n<tr>\r\n<td class="embedded" width="100" bgcolor="#F5F4EA">&nbsp; <b>User</b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded">The default class of new members.</td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" bgcolor="#F5F4EA">&nbsp; <b>Power User</b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded">Can download DOX over 1MB and view NFO files.</td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" bgcolor="#F5F4EA">&nbsp;<img src="pic/star.gif" alt="Star"/></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded">Has donated money to TorrentBits.org . </td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" valign="top" bgcolor="#F5F4EA">&nbsp; <b>VIP</b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded" valign="top">Same privileges as Power User and is considered an Elite Member of TorrentBits. Immune to automatic demotion.</td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" bgcolor="#F5F4EA">&nbsp; <b>Other</b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded">Customised title.</td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" bgcolor="#F5F4EA">&nbsp; <b><font color="#4040c0">Uploader</font></b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded">Same as PU except with upload rights and immune to automatic demotion.</td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" valign="top" bgcolor="#F5F4EA">&nbsp; <b><font color="#A83838">Moderator</font></b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded" valign="top">Can edit and delete any uploaded torrents. Can also moderate usercomments and disable accounts.</td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" bgcolor="#F5F4EA">&nbsp; <b><font color="#A83838">Administrator</font></b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded">Can do just about anything.</td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" bgcolor="#F5F4EA">&nbsp; <b><font color="#A83838">SysOp</font></b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded">Redbeard (site owner).</td>\r\n</tr>\r\n</table>', '1', 2, 10);
INSERT INTO `faq` VALUES (23, 'item', 'How does this promotion thing work anyway?', '<table cellspacing="3" cellpadding="0">\r\n<tr>\r\n<td class="embedded" bgcolor="#F5F4EA" valign="top" width="100">&nbsp; <b>Power User</b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded" valign="top">Must have been be a member for at least 4 weeks, have uploaded at least 25GB and\r\nhave a ratio at or above 1.05.<br/>\r\nThe promotion is automatic when these conditions are met. Note that you will be automatically demoted from<br/>\r\nthis status if your ratio drops below 0.95 at any time.</td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" bgcolor="#F5F4EA">&nbsp; <img src="pic/star.gif" alt="Star"/></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded">Just donate, and send <a class="altlink" href="sendmessage.php?receiver=2">Redbeard</a> - and only\r\nRedbeard - the details.</td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" bgcolor="#F5F4EA" valign="top">&nbsp; <b>VIP</b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded" valign="top">Assigned by mods at their discretion to users they feel contribute something special to the site.<br/>\r\n(Anyone begging for VIP status will be automatically disqualified.)</td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" bgcolor="#F5F4EA">&nbsp; <b>Other</b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded">Conferred by mods at their discretion (not available to Users or Power Users).</td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" bgcolor="#F5F4EA">&nbsp; <b><font color="#4040c0">Uploader</font></b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded">Appointed by Admins/SysOp (see the ''Uploading'' section for conditions).</td>\r\n</tr>\r\n<tr>\r\n<td class="embedded" bgcolor="#F5F4EA">&nbsp; <b><font color="#A83838">Moderator</font></b></td>\r\n<td class="embedded" width="5">&nbsp;</td>\r\n<td class="embedded">You don''t ask us, we''ll ask you!</td>\r\n</tr>\r\n</table>', '1', 2, 11);
INSERT INTO `faq` VALUES (24, 'item', 'Hey! I''ve seen Power Users with less than 25GB uploaded!', 'The PU limit used to be 10GB and we didn''t demote anyone when we raised it to 25GB.', '1', 2, 12);
INSERT INTO `faq` VALUES (25, 'item', 'Why can''t my friend become a member?', 'There is a 75.000 users limit. When that number is reached we stop accepting new members. Accounts inactive for more than 42 days are automatically deleted, so keep trying. (There is no reservation or queuing system, don''t ask for that.)', '2', 2, 13);
INSERT INTO `faq` VALUES (26, 'item', 'How do I add an avatar to my profile?', 'First, find an image that you like, and that is within the\r\n<a class="altlink" href="rules.php">rules</a>. Then you will have\r\nto find a place to host it, such as our own <a class="altlink" href="bitbucket-upload.php">BitBucket</a>.\r\n(Other popular choices are <a class="altlink" href="http://photobucket.com/">Photobucket</a>,\r\n<a class="altlink" href="http://uploadit.org/">Upload-It!</a> or\r\n<a class="altlink" href="http://www.imageshack.us/">ImageShack</a>).\r\nAll that is left to do is copy the URL you were given when\r\nuploading it to the avatar field in your <a class="altlink" href="my.php">profile</a>.<br/>\r\n<br/>\r\nPlease do not make a post just to test your avatar. If everything is allright you''ll see it\r\nin your <a class="altlink" href="userdetails.php">details page</a>.', '1', 2, 14);
INSERT INTO `faq` VALUES (27, 'item', 'Most common reason for stats not updating', '<ul>\r\n<li>The user is cheating. (a.k.a. &quot;Summary Ban&quot;)</li>\r\n<li>The server is overloaded and unresponsive. Just try to keep the session open until the server responds again. (Flooding the server with consecutive manual updates is not recommended.)</li>\r\n<li>You are using a faulty client. If you want to use an experimental or CVS version you do it at your own risk.</li>\r\n</ul>', '1', 3, 1);
INSERT INTO `faq` VALUES (28, 'item', 'Best practices', '<ul>\r\n<li>If a torrent you are currently leeching/seeding is not listed on your profile, just wait or force a manual update.</li>\r\n<li>Make sure you exit your client properly, so that the tracker receives &quot;event=completed&quot;.</li>\r\n<li>If the tracker is down, do not stop seeding. As long as the tracker is back up before you exit the client the stats should update properly.</li>\r\n</ul>', '1', 3, 2);
INSERT INTO `faq` VALUES (29, 'item', 'May I use any bittorrent client?', 'Yes. The tracker now updates the stats correctly for all bittorrent clients. However, we still recommend\r\nthat you <b>avoid</b> the following clients:<br/>\r\n<br/>\r\n� BitTorrent++,<br/>\r\n� Nova Torrent,<br/>\r\n� TorrentStorm.<br/>\r\n<br/>\r\nThese clients do not report correctly to the tracker when canceling/finishing a torrent session.\r\nIf you use them then a few MB may not be counted towards\r\nthe stats near the end, and torrents may still be listed in your profile for some time after you have closed the client.<br/>\r\n<br/>\r\nAlso, clients in alpha or beta version should be avoided.', '1', 3, 3);
INSERT INTO `faq` VALUES (30, 'item', 'Why is a torrent I''m leeching/seeding listed several times in my profile?', 'If for some reason (e.g. pc crash, or frozen client) your client exits improperly and you restart it,\r\nit will have a new peer_id, so it will show as a new torrent. The old one will never receive a &quot;event=completed&quot;\r\nor &quot;event=stopped&quot; and will be listed until some tracker timeout. Just ignore it, it will eventually go away.', '1', 3, 4);
INSERT INTO `faq` VALUES (31, 'item', 'I''ve finished or cancelled a torrent. Why is it still listed in my profile?', 'Some clients, notably TorrentStorm and Nova Torrent, do not report properly to the tracker when canceling or finishing a torrent.\r\nIn that case the tracker will keep waiting for some message - and thus listing the torrent as seeding or leeching - until some\r\ntimeout occurs. Just ignore it, it will eventually go away.', '1', 3, 5);
INSERT INTO `faq` VALUES (32, 'item', 'Why do I sometimes see torrents I''m not leeching in my profile!?', 'When a torrent is first started, the tracker uses the IP to identify the user. Therefore the torrent will\r\nbecome associated with the user <i>who last accessed the site</i> from that IP. If you share your IP in some\r\nway (you are behind NAT/ICS, or using a proxy), and some of the persons you share it with are also users,\r\nyou may occasionally see their torrents listed in your profile. (If they start a torrent session from that\r\nIP and you were the last one to visit the site the torrent will be associated with you). Note that now\r\ntorrents listed in your profile will always count towards your total stats.', '2', 3, 6);
INSERT INTO `faq` VALUES (33, 'item', 'Multiple IPs (Can I login from different computers?)', 'Yes, the tracker is now capable of following sessions from different IPs for the same user. A torrent is associated with the user when it starts, and only at that moment is the IP relevant. So if you want to seed/leech from computer A and computer B with the same account you should access the site from computer A, start the torrent there, and then repeat both steps from computer B (not limited to two computers or to a single torrent on each, this is just the simplest example). You do not need to login again when closing the torrent.\r\n', '2', 3, 7);
INSERT INTO `faq` VALUES (34, 'item', 'How does NAT/ICS change the picture?', 'This is a very particular case in that all computers in the LAN will appear to the outside world as having the same IP. We must distinguish\r\nbetween two cases:<br/>\r\n<br/>\r\n<b>1.</b> <i>You are the single TorrentBits users in the LAN</i><br/>\r\n<br/>\r\nYou should use the same TorrentBits account in all the computers.<br/>\r\n<br/>\r\nNote also that in the ICS case it is preferable to run the BT client on the ICS gateway. Clients running on the other computers\r\nwill be unconnectable (their ports will be listed as &quot;---&quot;, as explained elsewhere in the FAQ) unless you specify\r\nthe appropriate services in your ICS configuration (a good explanation of how to do this for Windows XP can be found\r\n<a class="altlink" href="redir.php?url=http://www.microsoft.com/downloads/details.aspx?FamilyID=1dcff3ce-f50f-4a34-ae67-cac31ccd7bc9&amp;displaylang=en">here</a>).\r\nIn the NAT case you should configure different ranges for clients on different computers and create appropriate NAT rules in the router. (Details vary widely from router to router and are outside the scope of this FAQ. Check your router documentation and/or support forum.)<br/>\r\n<br/>\r\n<br/>\r\n<b>2.</b> <i>There are multiple TorrentBits users in the LAN</i><br/>\r\n<br/>\r\nAt present there is no way of making this setup always work properly with TorrentBits.\r\nEach torrent will be associated with the user who last accessed the site from within\r\nthe LAN before the torrent was started.\r\nUnless there is cooperation between the users mixing of statistics is possible.\r\n(User A accesses the site, downloads a .torrent file, but does not start the torrent immediately.\r\nMeanwhile, user B accesses the site. User A then starts the torrent. The torrent will count\r\ntowards user B''s statistics, not user A''s.)\r\n<br/>\r\n<br/>\r\nIt is your LAN, the responsibility is yours. Do not ask us to ban other users\r\nwith the same IP, we will not do that. (Why should we ban <i>him</i> instead of <i>you</i>?)', '1', 3, 8);
INSERT INTO `faq` VALUES (35, 'item', 'For those of you who are interested...', 'Some <a class="altlink" href="anatomy.php">info</a> about the &quot;Anatomy of a torrent session&quot;.', '1', 3, 9);
INSERT INTO `faq` VALUES (36, 'item', 'Why can''t I upload torrents?', 'Only specially authorized users (<font color="#4040c0"><b>Uploaders</b></font>) have permission to upload torrents.', '1', 4, 1);
INSERT INTO `faq` VALUES (37, 'item', 'What criteria must I meet before I can join the <font color="#4040c0">Uploader</font> team?', 'You must be able to provide releases that:<br/>\r\n� include a proper NFO,<br/>\r\n� are genuine scene releases. If it''s not on <a class="altlink" href="redir.php?url=http://www.nforce.nl">NFOrce</a> then forget it! (except music).<br/>\r\n� are not older than seven (7) days,<br/>\r\n� have all files in original format (usually 14.3 MB RARs),<br/>\r\n� you''ll be able to seed, or make sure are well-seeded, for at least 24 hours.<br/>\r\n� you should have atleast 2MBit upload bandwith.<br/>\r\n<br/>\r\nIf you think you can match these criteria do not hesitate to <a class="altlink" href="staff.php">contact</a> one of the administrators.<br/>\r\n<b>Remember!</b> Write your application carefully! Be sure to include your UL speed and what kind of stuff you''re planning to upload.<br/>\r\nOnly well written letters with serious intent will be considered.', '1', 4, 2);
INSERT INTO `faq` VALUES (38, 'item', 'Can I upload your torrents to other trackers?', 'No. We are a closed, limited-membership community. Only registered users can use the TB tracker.\r\nPosting our torrents on other trackers is useless, since most people who attempt to download them will\r\nbe unable to connect with us. This generates a lot of frustration and bad-will against us at TorrentBits,\r\nand will therefore not be tolerated.<br/>\r\n<br/>\r\nComplaints from other sites'' administrative staff about our torrents being posted on their sites will\r\nresult in the banning of the users responsible.<br/>\r\n<br/>\r\n(However, the files you download from us are yours to do as you please. You can always create another\r\ntorrent, pointing to some other tracker, and upload it to the site of your choice.)', '3', 4, 3);
INSERT INTO `faq` VALUES (39, 'item', 'How do I use the files I''ve downloaded?', 'Check out <a class="altlink" href="videoformats.php">this guide</a>.', '1', 5, 1);
INSERT INTO `faq` VALUES (40, 'item', 'Downloaded a movie and don''t know what CAM/TS/TC/SCR means?', 'Check out <a class="altlink" href="videoformats.php">this guide</a>.', '1', 5, 2);
INSERT INTO `faq` VALUES (41, 'item', 'Why did an active torrent suddenly disappear?', 'There may be three reasons for this:<br/>\r\n(<b>1</b>) The torrent may have been out-of-sync with the site\r\n<a class="altlink" href="rules.php">rules</a>.<br/>\r\n(<b>2</b>) The uploader may have deleted it because it was a bad release.\r\nA replacement will probably be uploaded to take its place.<br/>\r\n(<b>3</b>) Torrents are automatically deleted after 28 days.', '2', 5, 3);
INSERT INTO `faq` VALUES (42, 'item', 'How do I resume a broken download or reseed something?', 'Open the .torrent file. When your client asks you for a location, choose the location of the existing file(s) and it will resume/reseed the torrent.\r\n', '1', 5, 4);
INSERT INTO `faq` VALUES (43, 'item', 'Why do my downloads sometimes stall at 99%?', 'The more pieces you have, the harder it becomes to find peers who have pieces you are missing. That is why downloads sometimes slow down or even stall when there are just a few percent remaining. Just be patient and you will, sooner or later, get the remaining pieces.\r\n', '1', 5, 5);
INSERT INTO `faq` VALUES (44, 'item', 'What are these "a piece has failed an hash check" messages?', 'Bittorrent clients check the data they receive for integrity. When a piece fails this check it is\r\nautomatically re-downloaded. Occasional hash fails are a common occurrence, and you shouldn''t worry.<br/>\r\n<br/>\r\nSome clients have an (advanced) option/preference to ''kick/ban clients that send you bad data'' or\r\nsimilar. It should be turned on, since it makes sure that if a peer repeatedly sends you pieces that\r\nfail the hash check it will be ignored in the future.', '1', 5, 6);
INSERT INTO `faq` VALUES (45, 'item', 'The torrent is supposed to be 100MB. How come I downloaded 120MB?', 'See the hash fails topic. If your client receives bad data it will have to redownload it, therefore\r\nthe total downloaded may be larger than the torrent size. Make sure the &quot;kick/ban&quot; option is turned on\r\nto minimize the extra downloads.', '1', 5, 7);
INSERT INTO `faq` VALUES (46, 'item', 'Why do I get a "Not authorized (xx h) - READ THE FAQ" error?', 'From the time that each <b>new</b> torrent is uploaded to the tracker, there is a period of time that\r\nsome users must wait before they can download it.<br/>\r\nThis delay in downloading will only affect users with a low ratio, and users with low upload amounts.<br/>\r\n<br/>\r\n<table cellspacing="3" cellpadding="0">\r\n <tr>\r\n	<td class="embedded" width="70">Ratio below</td>\r\n	<td class="embedded" width="40" bgcolor="#F5F4EA"><div align="center"><font color="#BB0000">0.50</font></div></td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded" width="110">and/or upload below</td>\r\n	<td class="embedded" width="40" bgcolor="#F5F4EA"><div align="center">5.0GB</div></td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded" width="50">delay of</td>\r\n	<td class="embedded" width="40" bgcolor="#F5F4EA"><div align="center">48h</div></td>\r\n </tr>\r\n <tr>\r\n	<td class="embedded">Ratio below</td>\r\n	<td class="embedded" bgcolor="#F5F4EA"><div align="center"><font color="#A10000">0.65</font></div></td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded">and/or upload below</td>\r\n	<td class="embedded" bgcolor="#F5F4EA"><div align="center">6.5GB</div></td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded">delay of</td>\r\n	<td class="embedded" bgcolor="#F5F4EA"><div align="center">24h</div></td>\r\n </tr>\r\n <tr>\r\n	<td class="embedded">Ratio below</td>\r\n	<td class="embedded" bgcolor="#F5F4EA"><div align="center"><font color="#880000">0.80</font></div></td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded">and/or upload below</td>\r\n	<td class="embedded" bgcolor="#F5F4EA"><div align="center">8.0GB</div></td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded">delay of</td>\r\n	<td class="embedded" bgcolor="#F5F4EA"><div align="center">12h</div></td>\r\n </tr>\r\n <tr>\r\n	<td class="embedded">Ratio below</td>\r\n	<td class="embedded" bgcolor="#F5F4EA"><div align="center"><font color="#6E0000">0.95</font></div></td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded">and/or upload below</td>\r\n	<td class="embedded" bgcolor="#F5F4EA"><div align="center">9.5GB</div></td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded">delay of</td>\r\n	<td class="embedded" bgcolor="#F5F4EA"><div align="center">06h</div></td>\r\n </tr>\r\n</table>\r\n<br/>\r\n"<b>And/or</b>" means any or both. Your delay will be the <b>largest</b> one for which you meet <b>at least</b> one condition.<br/>\r\n<br/>\r\nThis applies to new users as well, so opening a new account will not help. Note also that this\r\nworks at tracker level, you will be able to grab the .torrent file itself at any time.<br/>\r\n<br/>\r\n<!--The delay applies only to leeching, not to seeding. If you got the files from any other source and\r\nwish to seed them you may do so at any time irrespectively of your ratio or total uploaded.<br/>-->\r\nN.B. Due to some users exploiting the ''no-delay-for-seeders'' policy we had to change it. The delay\r\nnow applies to both seeding and leeching. So if you are subject to a delay and get the files from\r\nsome other source you will not be able to seed them until the delay has elapsed.', '3', 5, 8);
INSERT INTO `faq` VALUES (47, 'item', 'Why do I get a "rejected by tracker - Port xxxx is blacklisted" error?', 'Your client is reporting to the tracker that it uses one of the default bittorrent ports\r\n(6881-6889) or any other common p2p port for incoming connections.<br/>\r\n<br/>\r\nTorrentBits does not allow clients to use ports commonly associated with p2p protocols.\r\nThe reason for this is that it is a common practice for ISPs to throttle those ports\r\n(that is, limit the bandwidth, hence the speed). <br/>\r\n<br/>\r\nThe blocked ports list include, but is not neccessarily limited to, the following:<br/>\r\n<br/>\r\n<table cellspacing="3" cellpadding="0">\r\n  <tr>\r\n	<td class="embedded" width="80">Direct Connect</td>\r\n	<td class="embedded" width="80" bgcolor="#F5F4EA"><div align="center">411 - 413</div></td>\r\n  </tr>\r\n  <tr>\r\n	<td class="embedded" width="80">Kazaa</td>\r\n	<td class="embedded" width="80" bgcolor="#F5F4EA"><div align="center">1214</div></td>\r\n  </tr>\r\n  <tr>\r\n	<td class="embedded" width="80">eDonkey</td>\r\n	<td class="embedded" width="80" bgcolor="#F5F4EA"><div align="center">4662</div></td>\r\n  </tr>\r\n  <tr>\r\n	<td class="embedded" width="80">Gnutella</td>\r\n	<td class="embedded" width="80" bgcolor="#F5F4EA"><div align="center">6346 - 6347</div></td>\r\n  </tr>\r\n  <tr>\r\n	<td class="embedded" width="80">BitTorrent</td>\r\n	<td class="embedded" width="80" bgcolor="#F5F4EA"><div align="center">6881 - 6889</div></td>\r\n </tr>\r\n</table>\r\n<br/>\r\nIn order to use use our tracker you must  configure your client to use\r\nany port range that does not contain those ports (a range within the region 49152 through 65535 is preferable,\r\ncf. <a class="altlink" href="http://www.iana.org/assignments/port-numbers">IANA</a>). Notice that some clients,\r\nlike Azureus 2.0.7.0 or higher, use a single port for all torrents, while most others use one port per open torrent. The size\r\nof the range you choose should take this into account (typically less than 10 ports wide. There\r\nis no benefit whatsoever in choosing a wide range, and there are possible security implications). <br/>\r\n<br/>\r\nThese ports are used for connections between peers, not client to tracker.\r\nTherefore this change will not interfere with your ability to use other trackers (in fact it\r\nshould <i>increase</i> your speed with torrents from any tracker, not just ours). Your client\r\nwill also still be able to connect to peers that are using the standard ports.\r\nIf your client does not allow custom ports to be used, you will have to switch to one that does.<br/>\r\n<br/>\r\nDo not ask us, or in the forums, which ports you should choose. The more random the choice is the harder\r\nit will be for ISPs to catch on to us and start limiting speeds on the ports we use.\r\nIf we simply define another range ISPs will start throttling that range also. <br/>\r\n<br/>\r\nFinally, remember to forward the chosen ports in your router and/or open them in your\r\nfirewall, should you have them.', '3', 5, 9);
INSERT INTO `faq` VALUES (48, 'item', 'What''s this "IOError - [Errno13] Permission denied" error?', 'If you just want to fix it reboot your computer, it should solve the problem.\r\nOtherwise read on.<br/>\r\n<br/>\r\nIOError means Input-Output Error, and that is a file system error, not a tracker one.\r\nIt shows up when your client is for some reason unable to open the partially downloaded\r\ntorrent files. The most common cause is two instances of the client to be running\r\nsimultaneously:\r\nthe last time the client was closed it somehow didn''t really close but kept running in the\r\nbackground, and is therefore still\r\nlocking the files, making it impossible for the new instance to open them.<br/>\r\n<br/>\r\nA more uncommon occurrence is a corrupted FAT. A crash may result in corruption\r\nthat makes the partially downloaded files unreadable, and the error ensues. Running\r\nscandisk should solve the problem. (Note that this may happen only if you''re running\r\nWindows 9x - which only support FAT - or NT/2000/XP with FAT formatted hard drives.\r\nNTFS is much more robust and should never permit this problem.)', '3', 5, 10);
INSERT INTO `faq` VALUES (49, 'item', 'What''s this "TTL" in the browse page?', 'The torrent''s Time To Live, in hours. It means the torrent will be deleted\r\nfrom the tracker after that many hours have elapsed (yes, even if it is still active).\r\nNote that this a maximum value, the torrent may be deleted at any time if it''s inactive.', '3', 5, 11);
INSERT INTO `faq` VALUES (50, 'item', 'Do not immediately jump on new torrents', 'The download speed mostly depends on the seeder-to-leecher ratio (SLR). Poor download speed is\r\nmainly a problem with new and very popular torrents where the SLR is low.<br/>\r\n<br/>\r\n(Proselytising sidenote: make sure you remember that you did not enjoy the low speed.\r\n<b>Seed</b> so that others will not endure the same.)<br/>\r\n<br/>\r\nThere are a couple of things that you can try on your end to improve your speed:<br/>\r\n<br/>In particular, do not do it if you have a slow connection. The best speeds will be found around the\r\nhalf-life of a torrent, when the SLR will be at its highest. (The downside is that you will not be able to seed\r\nso much. It''s up to you to balance the pros and cons of this.)', '1', 6, 1);
INSERT INTO `faq` VALUES (51, 'item', 'Limit your upload speed', 'The upload speed affects the download speed in essentially two ways:<br/>\r\n<ul>\r\n    <li>Bittorrent peers tend to favour those other peers that upload to them. This means that if A and B\r\n	are leeching the same torrent and A is sending data to B at high speed then B will try to reciprocate.\r\n	So due to this effect high upload speeds lead to high download speeds.</li>\r\n\r\n    <li>Due to the way TCP works, when A is downloading something from B it has to keep telling B that\r\n        it received the data sent to him. (These are called acknowledgements - ACKs -, a sort of &quot;got it!&quot; messages).\r\n        If A fails to do this then B will stop sending data and wait. If A is uploading at full speed there may be no\r\n        bandwidth left for the ACKs and they will be delayed. So due to this effect excessively high upload speeds lead\r\n        to low download speeds.</li>\r\n</ul>\r\n\r\nThe full effect is a combination of the two. The upload should be kept as high as possible while allowing the\r\nACKs to get through without delay. <b>A good thumb rule is keeping the upload at about 80% of the theoretical\r\nupload speed.</b> You will have to fine tune yours to find out what works best for you. (Remember that keeping the\r\nupload high has the additional benefit of helping with your ratio.) <br/>\r\n<br/>\r\nIf you are running more than one instance of a client it is the overall upload speed that you must take into account.\r\nSome clients (e.g. Azureus) limit global upload speed, others (e.g. Shad0w''s) do it on a per torrent basis.\r\nKnow your client. The same applies if you are using your connection for anything else (e.g. browsing or ftp),\r\nalways think of the overall upload speed.', '1', 6, 2);
INSERT INTO `faq` VALUES (52, 'item', 'Limit the number of simultaneous connections', 'Some operating systems (like Windows 9x) do not deal well with a large number of connections, and may even crash.\r\nAlso some home routers (particularly when running NAT and/or firewall with stateful inspection services) tend to become\r\nslow or crash when having to deal with too many connections. There are no fixed values for this, you may try 60 or 100\r\nand experiment with the value. Note that these numbers are additive, if you have two instances of\r\na client running the numbers add up.', '1', 6, 3);
INSERT INTO `faq` VALUES (53, 'item', 'Limit the number of simultaneous uploads', 'Isn''t this the same as above? No. Connections limit the number of peers your client is talking to and/or\r\ndownloading from. Uploads limit the number of peers your client is actually uploading to. The ideal number is\r\ntypically much lower than the number of connections, and highly dependent on your (physical) connection.', '1', 6, 4);
INSERT INTO `faq` VALUES (54, 'item', 'Just give it some time', 'As explained above peers favour other peers that upload to them. When you start leeching a new torrent you have\r\nnothing to offer to other peers and they will tend to ignore you. This makes the starts slow, in particular if,\r\nby change, the peers you are connected to include few or no seeders. The download speed should increase as soon\r\nas you have some pieces to share.', '1', 6, 5);
INSERT INTO `faq` VALUES (55, 'item', 'Why is my browsing so slow while leeching?', 'Your download speed is always finite. If you are a peer in a fast torrent it will almost certainly saturate your\r\ndownload bandwidth, and your browsing will suffer. At the moment there is no client that allows you to limit the\r\ndownload speed, only the upload. You will have to use a third-party solution,\r\nsuch as <a class="altlink" href="redir.php?url=http://www.netlimiter.com/">NetLimiter</a>.<br/>\r\n<br/>\r\nBrowsing was used just as an example, the same would apply to gaming, IMing, etc...', '1', 6, 6);
INSERT INTO `faq` VALUES (56, 'item', 'What is a proxy?', 'Basically a middleman. When you are browsing a site through a proxy your requests are sent to the proxy and the proxy\r\nforwards them to the site instead of you connecting directly to the site. There are several classifications\r\n(the terminology is far from standard):<br/>\r\n<br/>\r\n\r\n\r\n<table cellspacing="3" cellpadding="0">\r\n <tr>\r\n	<td class="embedded" valign="top" bgcolor="#F5F4EA" width="100">&nbsp;Transparent</td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded" valign="top">A transparent proxy is one that needs no configuration on the clients. It works by automatically redirecting all port 80 traffic to the proxy. (Sometimes used as synonymous for non-anonymous.)</td>\r\n </tr>\r\n <tr>\r\n	<td class="embedded" valign="top" bgcolor="#F5F4EA">&nbsp;Explicit/Voluntary</td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded" valign="top">Clients must configure their browsers to use them.</td>\r\n </tr>\r\n <tr>\r\n	<td class="embedded" valign="top" bgcolor="#F5F4EA">&nbsp;Anonymous</td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded" valign="top">The proxy sends no client identification to the server. (HTTP_X_FORWARDED_FOR header is not sent; the server does not see your IP.)</td>\r\n </tr>\r\n <tr>\r\n	<td class="embedded" valign="top" bgcolor="#F5F4EA">&nbsp;Highly Anonymous</td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded" valign="top">The proxy sends no client nor proxy identification to the server. (HTTP_X_FORWARDED_FOR, HTTP_VIA and HTTP_PROXY_CONNECTION headers are not sent; the server doesn''t see your IP and doesn''t even know you''re using a proxy.)</td>\r\n </tr>\r\n <tr>\r\n	<td class="embedded" valign="top" bgcolor="#F5F4EA">&nbsp;Public</td>\r\n	<td class="embedded" width="10">&nbsp;</td>\r\n	<td class="embedded" valign="top">(Self explanatory)</td>\r\n </tr>\r\n</table>\r\n<br/>\r\nA transparent proxy may or may not be anonymous, and there are several levels of anonymity.', '1', 7, 1);
INSERT INTO `faq` VALUES (57, 'item', 'How do I find out if I''m behind a (transparent/anonymous) proxy?', 'Try <a href="http://proxyjudge.org" class="altlink">ProxyJudge</a>. It lists the HTTP headers that the server where it is running\r\nreceived from you. The relevant ones are HTTP_CLIENT_IP, HTTP_X_FORWARDED_FOR and REMOTE_ADDR.<br/>\r\n<br/>\r\n<br/>\r\n<b>Why is my port listed as &quot;---&quot; even though I''m not NAT/Firewalled?</b><a name="prox3"></a><br/>\r\n<br/>\r\nThe TorrentBits tracker is quite smart at finding your real IP, but it does need the proxy to send the HTTP header\r\nHTTP_X_FORWARDED_FOR. If your ISP''s proxy does not then what happens is that the tracker will interpret the proxy''s IP\r\naddress as the client''s IP address. So when you login and the tracker tries to connect to your client to see if you are\r\nNAT/firewalled it will actually try to connect to the proxy on the port your client reports to be using for\r\nincoming connections. Naturally the proxy will not be listening on that port, the connection will fail and the\r\ntracker will think you are NAT/firewalled.', '1', 7, 2);
INSERT INTO `faq` VALUES (58, 'item', 'Can I bypass my ISP''s proxy?', 'If your ISP only allows HTTP traffic through port 80 or blocks the usual proxy ports then you would need to use something\r\nlike <a href="http://www.socks.permeo.com">socks</a> and that is outside the scope of this FAQ.<br/>\r\n<br/>\r\nThe site accepts connections on port 81 besides the usual 80, and using them may be enough to fool some proxies. So the first\r\nthing to try should be connecting to www.torrentbits.org:81. Note that even if this works your bt client will still try\r\nto connect to port 80 unless you edit the announce url in the .torrent file.<br/>\r\n<br/>\r\nOtherwise you may try the following:<br/>\r\n<ul>\r\n    <li>Choose any public <b>non-anonymous</b> proxy that does <b>not</b> use port 80\r\n	(e.g. from <a href="http://tools.rosinstrument.com/proxy"  class="altlink">this</a>,\r\n	<a href="http://www.proxy4free.com/index.html" class="altlink">this</a> or\r\n	<a href="http://www.samair.ru/proxy" class="altlink">this</a> list).</li>\r\n\r\n    <li>Configure your computer to use that proxy. For Windows XP, do <i>Start</i>, <i>Control Panel</i>, <i>Internet Options</i>,\r\n	<i>Connections</i>, <i>LAN Settings</i>, <i>Use a Proxy server</i>, <i>Advanced</i> and type in the IP and port of your chosen\r\n	proxy. Or from Internet Explorer use <i>Tools</i>, <i>Internet Options</i>, ...<br/></li>\r\n\r\n    <li>(Facultative) Visit <a href="http://proxyjudge.org" class="altlink">ProxyJudge</a>. If you see an HTTP_X_FORWARDED_FOR in\r\n	the list followed by your IP then everything should be ok, otherwise choose another proxy and try again.<br/></li>\r\n\r\n    <li>Visit TorrentBits. Hopefully the tracker will now pickup your real IP (check your profile to make sure).</li>\r\n</ul>\r\n<br/>\r\nNotice that now you will be doing all your browsing through a public proxy, which are typically quite slow.\r\nCommunications between peers do not use port 80 so their speed will not be affected by this, and should be better than when\r\nyou were &quot;unconnectable&quot;.', '1', 7, 3);
INSERT INTO `faq` VALUES (59, 'item', 'How do I make my bittorrent client use a proxy?', 'Just configure Windows XP as above. When you configure a proxy for Internet Explorer you''re actually configuring a proxy for\r\nall HTTP traffic (thank Microsoft and their &quot;IE as part of the OS policy&quot; ). On the other hand if you use another\r\nbrowser (Opera/Mozilla/Firefox) and configure a proxy there you''ll be configuring a proxy just for that browser. We don''t\r\nknow of any BT client that allows a proxy to be specified explicitly.', '1', 7, 4);
INSERT INTO `faq` VALUES (60, 'item', 'Why can''t I signup from behind a proxy?', 'It is our policy not to allow new accounts to be opened from behind a proxy.', '1', 7, 5);
INSERT INTO `faq` VALUES (61, 'item', 'Does this apply to other torrent sites?', 'This section was written for TorrentBits, a closed, port 80-81 tracker. Other trackers may be open or closed, and many listen\r\non e.g. ports 6868 or 6969. The above does <b>not</b> necessarily apply to other trackers.', '1', 7, 6);
INSERT INTO `faq` VALUES (62, 'item', 'Maybe my address is blacklisted?', 'The site blocks addresses listed in the (former) <a class="altlink" href="http://methlabs.org/">PeerGuardian</a>\r\ndatabase, as well as addresses of banned users. This works at Apache/PHP level, it''s just a script that\r\nblocks <i>logins</i> from those addresses. It should not stop you from reaching the site. In particular\r\nit does not block lower level protocols, you should be able to ping/traceroute the server even if your\r\naddress is blacklisted. If you cannot then the reason for the problem lies elsewhere.<br/>\r\n<br/>\r\nIf somehow your address is indeed blocked in the PG database do not contact us about it, it is not our\r\npolicy to open <i>ad hoc</i> exceptions. You should clear your IP with the database maintainers instead.', '1', 8, 1);
INSERT INTO `faq` VALUES (63, 'item', 'Your ISP blocks the site''s address', '(In first place, it''s unlikely your ISP is doing so. DNS name resolution and/or network problems are the usual culprits.)\r\n<br/>\r\nThere''s nothing we can do.\r\nYou should contact your ISP (or get a new one). Note that you can still visit the site via a proxy, follow the instructions\r\nin the relevant section. In this case it doesn''t matter if the proxy is anonymous or not, or which port it listens to.<br/>\r\n<br/>\r\nNotice that you will always be listed as an &quot;unconnectable&quot; client because the tracker will be unable to\r\ncheck that you''re capable of accepting incoming connections.', '1', 8, 2);
INSERT INTO `faq` VALUES (64, 'item', 'Alternate port (81)', 'Some of our torrents use ports other than the usual HTTP port 80. This may cause problems for some users,\r\nfor instance those behind some firewall or proxy configurations.\r\n\r\nYou can easily solve this by editing the .torrent file yourself with any torrent editor, e.g.\r\n<a href="http://sourceforge.net/projects/burst/" class="altlink">MakeTorrent</a>,\r\nand replacing the announce url torrentbits.org:81 with torrentbits.org:80 or just torrentbits.org.<br/>\r\n<br/>\r\nEditing the .torrent with Notepad is not recommended. It may look like a text file, but it is in fact\r\na bencoded file. If for some reason you must use a plain text editor, change the announce url to\r\ntorrentbits.org:80, not torrentbits.org. (If you''re thinking about changing the number before the\r\nannounce url instead, you know too much to be reading this.)', '2', 8, 3);
INSERT INTO `faq` VALUES (65, 'item', 'You can try these:', 'Post in the <a class="altlink" href="forums.php">Forums</a>, by all means. You''ll find they\r\nare usually a friendly and helpful place,\r\nprovided you follow a few basic guidelines:\r\n<ul>\r\n<li>Make sure your problem is not really in this FAQ. There''s no point in posting just to be sent\r\nback here.</li>\r\n<li>Before posting read the sticky topics (the ones at the top). Many times new information that\r\nstill hasn''t been incorporated in the FAQ can be found there.</li>\r\n<li>Help us in helping you. Do not just say "it doesn''t work!". Provide details so that we don''t\r\nhave to guess or waste time asking. What client do you use? What''s your OS? What''s your network setup? What''s the exact\r\nerror message you get, if any? What are the torrents you are having problems with? The more\r\nyou tell the easiest it will be for us, and the more probable your post will get a reply.</li>\r\n<li>And needless to say: be polite. Demanding help rarely works, asking for it usually does\r\nthe trick.</li></ul>', '1', 9, 1);


ALTER TABLE users ADD(support enum ('yes','no') NOT NULL default 'no');
ALTER TABLE `users` ADD `supportfor` TEXT NOT NULL; 

-- --------------------------------------------------------

-- 
-- Table structure for table `ratings`
-- 

CREATE TABLE `ratings` (
  `torrent` int(10) unsigned NOT NULL default '0',
  `user` int(10) unsigned NOT NULL default '0',
  `rating` tinyint(3) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`torrent`,`user`),
  KEY `user` (`user`)
) TYPE=MyISAM;

-- --------------------------------------------------------

CREATE TABLE `staffmessages` (
`id` int(10) unsigned NOT NULL auto_increment,
`sender` int(10) unsigned NOT NULL default '0',
`added` datetime default NULL,
`msg` text,
`subject` varchar(100) NOT NULL default '',
`answeredby` int(10) unsigned NOT NULL default '0',
`answered` tinyint(1) NOT NULL default '0',
`answer` text,
PRIMARY KEY (`id`)
) TYPE=MyISAM;

-- Invite Hack --------

ALTER TABLE `users` ADD `invited_by` int(10) NOT NULL ;
ALTER TABLE `users` ADD `invitees` varchar(100) NOT NULL ;
ALTER TABLE `users` ADD `invites` smallint(5) NOT NULL ;
ALTER TABLE `users` ADD `invitedate` DATETIME;

-- Matching phpbb theme for current stylesheet --------

ALTER TABLE `stylesheets` ADD `phpbb_style` varchar(30) default 'default_phpbb_style' ;
