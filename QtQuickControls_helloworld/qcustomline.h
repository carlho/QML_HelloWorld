#ifndef QCUSTOMLINE_H
#define QCUSTOMLINE_H

#include <QtQuick/QQuickItem>
#include <QtQuick/qsgnode.h>
#include <QtQuick/qsgflatcolormaterial.h>
#include <math.h>

class QCustomLine : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(QPointF p1 READ p1 WRITE setP1 NOTIFY p1Changed)
    Q_PROPERTY(QPointF p2 READ p2 WRITE setP2 NOTIFY p2Changed)
    Q_PROPERTY(QColor linecolor READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(double linewidth READ linewidth WRITE setLinewidth NOTIFY linewidthChanged)


public:
    QCustomLine(QQuickItem *parent = 0);
    //~QLine();

    // Synchronisation point between the QML scene and the rendering scene graph
    // which all items with custom scene graph logic must implement.
    QSGNode *updatePaintNode(QSGNode *, UpdatePaintNodeData *);

    QPointF const p1() const { return m_p1; }
    QPointF const p2() const { return m_p2; }
    QColor const color() const { return _color; }
    double const linewidth() { return _linewidth; }

    void setP1(const QPointF &p);
    void setP2(const QPointF &p);
    void setColor(const QColor &c);
    void setLinewidth(const double l);

signals:
    void p1Changed(const QPointF &p);
    void p2Changed(const QPointF &p);
    void colorChanged(const QColor &c);
    void linewidthChanged(const double l);

private:
    QPointF m_p1;
    QPointF m_p2;
    QColor _color;
    double _linewidth;

    // Dashed line parameters
    bool _dashed;
    double _dashLength;
    double _spaceLength;
    double _edgeDash;
    int _nSegments;

    // Dashed line method
    void calcNormalisedDashedLengths();
};

#endif // QCUSTOMLINE_H
