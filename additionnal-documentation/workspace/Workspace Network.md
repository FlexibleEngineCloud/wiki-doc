## About "management network"

Management network is only used by management server to manage workspace desktop and also capture the audio / video / mouse & keyboard traffic in order to encapsule through the workspace manager to the end user (diagram to come)

In the creation process, take care to not overlap the management network with others subnet you'll use.

 

## What is the prerequisite of bandwidth for general desktop ?

- Average bandwidth: 300 kbps/ instance. Peak bandwidth: 5 Mbps/ instance.
- Packet loss rate ≤ 0.01%
- Round-trip delay ≤ 30 ms
- Network Jitter ≤ 10 ms(Floating in the range of ±10ms of average delay)

## What is the prerequisite of bandwidth for GPU Desktop ?

- Max bandwidth: 20 Mbps/ instance
- Packet loss rate ≤ 0.01%
- Round-trip delay ≤ 30 ms
- Network Jitter ≤ 10 ms(Floating in the range of ±10ms of average delay)
- These values are for reference only and may be more stringent depending on the application scenario.

 

## Do you have some example of bandwidth consumption for software ?

| **Scenario Type**                                 | **Scenario**               | **Bandwidth Reference Value** |
| ------------------------------------------------- | -------------------------- | ----------------------------- |
| **Silence**                                       | No application running     | 4 Kbit/s                      |
| Microsoft Office running without document editing | 20 Kbit/s                  |                               |
| **Office applications**                           | Word                       | 45 Kbit/s                     |
| PPT                                               | 589 Kbit/s                 |                               |
| **Video playback**                                | Standard definition (480p) | 6.85 Mbit/s                   |
| High definition (1080p)                           | 13.7 Mbit/s                |                               |
| **Other applications**                            | PDF                        | 265 Kbit/s                    |
| IE                                                | 150 Kbit/s                 |                               |
| Picture browsing                                  | 123 Kbit/s                 |                               |